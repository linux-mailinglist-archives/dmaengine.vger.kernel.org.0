Return-Path: <dmaengine+bounces-7504-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F38CA54C3
	for <lists+dmaengine@lfdr.de>; Thu, 04 Dec 2025 21:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CB74300CA83
	for <lists+dmaengine@lfdr.de>; Thu,  4 Dec 2025 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBB82ECEAE;
	Thu,  4 Dec 2025 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lgnvpoTo"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291773128D0;
	Thu,  4 Dec 2025 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764879408; cv=fail; b=m1NRmpO5674QMHEAnvYuVqM4OBIB0XF5XVqePCqozy0CoYcIeWC7IQ0ssAWnwjrU/YNw3DDrooY57mB3sSYpQ3dXGqcnqOdsPqdyeA5brXn+5FE6FQPFdrEgZic/+5F4dw529fMbMECMT6/NDqnaOBWRg8R6Y2fgtBc/NIFpwRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764879408; c=relaxed/simple;
	bh=GQvS7OacSA2kI8hxX1UF/QPdPUPF68E853f1rWMxf/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxET+JKzGVLGbEZvjSeW+vqGzglJwBIJ5+EiwD44y0b6Hl/DA4o4mq4pL+VQeOBOCyj3956y8SCK7X1eGfT9c015cQBNVyDzoimxOl30MW/BDu4hu4XmYvgA5SsPpaRMZkdgnKGPHqHumB3soUSPK9X8vnJfSGQeEG+mgAgBZ7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lgnvpoTo; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghAHEkSZ0xT+c67AjlIMJqAarCEeWCGukdw367EZelgnGPcM6kaXHuHpdpg9UYofFo+CrmJpurVpd0smWfzrwkn7Q6WGNjIbZUDjkdnmn5cCAQxxOZomNlWioK91StjasUXMe1wT6/LY2zb/e9Yi8C1YVp5viy0X19Wvs3ZMxN1cAacRWVr3JA6J6ZqXY6LfMwUwBcIfyRUNhmQF+maLCsxIs5Q+lsx5DqDKkpgAHlz34/McVhH8DAj7F0p9A5AGa+d43qhPxzC4HHaRKJNfagZBazYj9t9ey16sdvufCwSpA68ZvtFcJg1HxiZu4lO6kVcV30QlOGwM1EIefWCtUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJCCs6GjJxbKNgJAI12F7Hxlm/A3lIsL5WG+QY955sE=;
 b=t8EWoBMwtV95DfzNw2c+tA9iNIwVvBTNPsJcMgPMUPL7uXqUtKFEqw1avFEQITqmMVY1+Opa7OlG2NnVSaE5+kmsCmzTP4MtrBG9IUuBbPd7+545IBWo6JwszNWoTTL/A5fzROgbghvpVnwbYe0pTkU17aP8Z6VDch0Xwt4v2XjhxP6BZTZaLK/By9Rc8Gchn44rxbe8EbAb1uxtfatMNhcvL0jmEITUgO+BbR3m4nXLNU15ZKfoNV7YazV9RCM3/1KYQWRc2MVzNkgifuOR/s9sHALBNUzIi1pGgsb4shAH2KjRnOEEWVvR6v4LEEE2ox7qNjKxMhq/wscOgWE/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJCCs6GjJxbKNgJAI12F7Hxlm/A3lIsL5WG+QY955sE=;
 b=lgnvpoToGFdxM1pXmBjIKcUl9e3DIY18ZVrftjJtaItRhYIXGAr4nhWwpili2aTV+52vmYsQ6GAoTC5Z0V5mKJHWrbWRxLC+H6cD9owfmPQEd7/5r3hf7BuNcyrp0PhQFIio6QDfxrSQCPNtuGGLs43qFje4mnIH5ZSF/C0CH/euYqssJJyfTFI9H/GRYZNQxtyIixI8FNPibInHrb3kgafdhlhgmHI02knCYQsQpo81TzspG4Hb8KWW4hbFsVcxDeyHKcCNWFwcyNX2wFD2B9X1cRLPXRgHlgI9+G0DD8ena44Bnp3LVsK746erokwQt7qBccF2Cl1j2o3RSWZ2yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM9PR04MB8470.eurprd04.prod.outlook.com (2603:10a6:20b:415::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 20:16:39 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 20:16:39 +0000
Date: Thu, 4 Dec 2025 15:16:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 20/27] NTB: ntb_transport: Introduce remote eDMA
 backed transport mode
Message-ID: <aTHsGerE5phzLrgk@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-21-den@valinux.co.jp>
 <aS4Lcb+BjjCDeJRz@lizhi-Precision-Tower-5810>
 <jiigiyxb2hllpeh3znbfy4octtubvkkrbxv7qfzzivimvz7ky2@i7b7a66peapf>
 <aS8I5e2UguQ2/+uU@lizhi-Precision-Tower-5810>
 <27mhsc7pksxyv62ro2m4u4xblednmlgsvzm6e2gx4iqt2plrl2@ewtuiycdq3vj>
 <aTBh86H5m6PpIxMk@lizhi-Precision-Tower-5810>
 <47ns4b4oskh5yukig7sr4okhw6gvqf4q5yin2ibrpue5zrcplp@ybozsroia2fk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ns4b4oskh5yukig7sr4okhw6gvqf4q5yin2ibrpue5zrcplp@ybozsroia2fk>
X-ClientProxiedBy: BY5PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::26) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM9PR04MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c776267-316e-4a3f-140b-08de33720801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bM1xa91yZFZgug5f5tLQdG4gIPaq1z8vgpCS3TQKMbAClTDmregwbytwihKl?=
 =?us-ascii?Q?7dzZXnHnPjW2GWGGTB3YjQ/LHVSY7A7rSyNOIZYK3ZgCZWYd9yuLufbdvbr2?=
 =?us-ascii?Q?AfRz+5/OYFOgl5VykaTfDAZq+DIUBaoRv6NMop3BPZGegLn31JPtwvJ8ScB0?=
 =?us-ascii?Q?yXfNPeB0gfTL6ctxKRqApNuVakGutFO7OBZb+S535zcFb05PkOWaO0qwpDcY?=
 =?us-ascii?Q?t/9OSoxwlyQ2mGkOwKXDzmfJosh1E7Qbr8VqKWwr3bIYVoeznkN3/XgCWssb?=
 =?us-ascii?Q?R6QK7vVboBx45/kEkl8qx7HhGGZuGuYbsl8UqZMEfeQl9OHoqyJzVcC7WSg/?=
 =?us-ascii?Q?Nxb5Fn7Ezaz5sLy1r50qnT4ztMD5zqYzWVJ2jUlN6itAZTQT7L/pbKvUkhD7?=
 =?us-ascii?Q?nyUN4Zfnsfx1pE0KdtgQZbHYKIpnO7i657Q+oEcBtvbzl7TxEccLu8Lt8n2R?=
 =?us-ascii?Q?vQw1NZJ5SLdvZAJFFCoAr+9PeDg4mRHyM+bSU6tU4DMEMp1QbTyyPHgnjN+l?=
 =?us-ascii?Q?acTNaNUc5KXyHIeJ5yWXw+rTn5koQ15W/F3xcxqK4/zpM23S69mB8mLZI2dO?=
 =?us-ascii?Q?HNRK4fhppwRuYMVtq8+OtKtaTevCzR0TTVpR1BFDsADo66dLCmtzf99UejF5?=
 =?us-ascii?Q?kBo8FtMHo/H5j2wx6yNTvHSRiu99f7asPNuvk5125FZkbnwm9wcAcOLU9AIz?=
 =?us-ascii?Q?DY3VgGncVxEtOUAUiQEURBGopmJ/yUknQ0MopU64OzkYY1o/nsISWk/Hef1F?=
 =?us-ascii?Q?S41dsamuHr6B0usvKvEUzbGf7F+ZBPHq8Jb5pr4bid8RTK6xcaRY71idLh/b?=
 =?us-ascii?Q?TPRDyoUegqMNlBD25wS8tXgBRFpPUe/bOAo+kDJPS8/lge+MnZf+URYjGObV?=
 =?us-ascii?Q?IXYSHNhMhPliCHjTEZbfKYd1y82JpjKMLLVVZLhCbDLQJYqOLX//IJi7l1Hb?=
 =?us-ascii?Q?eW901JZcto/Ul2c5SNpsXbS1lkSZ/yns9jBOe+qK6+EGcuWrowGZY6TPs2wE?=
 =?us-ascii?Q?eW+yULAlMFGaxV6BuXWXyB2nrlFl5whFqqV3nYyOA8hReTkP8TAl57hNwBDR?=
 =?us-ascii?Q?LSIPy/7WJsrlYYUsp5ufTleOydtFqRakJeW2r1e0SWw9boDwN6tX8I00Oxei?=
 =?us-ascii?Q?WwK05fMMU1Qsn2FqnYjXXA7KeDBQJJRq74JSjcutIC0l47ssy2TueTYKYBGc?=
 =?us-ascii?Q?4M4k4CHuwUwP6rsUSZ9hP8cgQodrVbZad4gcdClHknKz0USW9SI2+c9j1oyx?=
 =?us-ascii?Q?oHdqhL2TBxx6P4jmaLBVJ/EeD5pMjuSiPQWOdMJeXADLlKj61yoJ/AylxPcp?=
 =?us-ascii?Q?/hmHzA+edpU1vz6ivRL90ny3jg0jfpivoUDaZNxnFD8KpbxCRO42UpkgKqQQ?=
 =?us-ascii?Q?6Tqd/6RNmTD10qGStx3WJ8JMBBuhLllmrPXVMUokVQeV4nNHvF3HZhatVJJ6?=
 =?us-ascii?Q?Yp3c6xoj2yc0in7gW1MTye7RQ7/SI/hLLm4gs9ezsX8Kb59z8614cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqBhYMiMohkoOXDpoYx8yxDm+3YS0EMkfZtcHSog8zPb56GKeDNUWDqfKBmF?=
 =?us-ascii?Q?zNLqvEmgfIAsrhQtZDDVDZoNxd5rh9ZoID7Hv4UaQTypBxg+Wa1fWN/IhqfM?=
 =?us-ascii?Q?GrSjEi+6VLsN9mlzztsrxWCJNwbHRRlpoiq7gjt4cx5KZcQPX4y8amxlaOQI?=
 =?us-ascii?Q?bz/fRnd42MvKbVwdEHXXnFtSVnLeqw/5FIkfX3yEua1y9FO2MELNAIAuuQij?=
 =?us-ascii?Q?ZM76NXq3wNH2Vl5iOoHCW4l5e/M/RcBexnkGT6JRElOQmUTUUHriH+J1SHbu?=
 =?us-ascii?Q?QcN5gg27KtdsYWV8+jxDbDHc6FzBW0k3SmZ0RFfEuZeWot+qQ0nLZZTE92Gu?=
 =?us-ascii?Q?fTzIYoLVCbUMYly1LQMW3Erv4byudmRIWs/A24eSEZdocQ97QHeFh0br3QC/?=
 =?us-ascii?Q?hss1Oe2EJnHZiQXdBwtx/CcB4NB3p+qNWwwX9wrtN6SYbknpfCGWCAISg09L?=
 =?us-ascii?Q?aaX2o4A7K84L482jGfEAxGAAbOxqBeZSKJez2xGLXL5IovWnPmRARmVJ5SE0?=
 =?us-ascii?Q?VU/KqyM4QCU7wz/Vpce5/Ud4fQqZ0ntriMPC4zY39i4ymcoQ6gIg6dUDTveT?=
 =?us-ascii?Q?Yx7rlS1hXlOFsWKYy2t8qBLyvCzzQ/K72634mvaKoqDJZhQLrJGmscFMlbsQ?=
 =?us-ascii?Q?zwyUQRdj4rQs5quVctnP7u8q4xrWuM1hZhQRopBq7WyaRtvSWBwyfxVaQdPx?=
 =?us-ascii?Q?t1APghUcVphMIO9bYmtV0hjfBuCajB4Y4X1/sTFNWG0FkD8wsx1h/0AMDNfc?=
 =?us-ascii?Q?12D0uqi0S0vbeAjL4FGKaK7/FAQm4P0aH33q/9cnnxgtUacLM8yhY3Vb+9E7?=
 =?us-ascii?Q?cX13tr1gSHqVBGG+L4muYWEnuNW9sUhmikpflf/TDvJW0PuEMfzsJbGoTPJR?=
 =?us-ascii?Q?7ZT8ZrbmIGFOLobmmfRmEyywbcBhvs/eNl3fwYHoKlWmlLJVCQkoNOFxCZRA?=
 =?us-ascii?Q?+ItJDXU4E/Kw4JtHzKjDwClmsQpKj44C/hL6necBDeTHe02bkuy4TdwUS6Cr?=
 =?us-ascii?Q?OCpc5d6seX2z8r2rXCSkwV8eHmTsvU08j5upoKiBYfcb7iiMeumC19UoL1Je?=
 =?us-ascii?Q?daLTA6DeZXrjNlEgVeYsILuTPjzN1gw5lpYUNUcBUsccOyTsdB/oUPzkm2U4?=
 =?us-ascii?Q?9afoYLFt9Fhqf2n75lhmrGBbkk0PtVyc3NQ9R3d+vtEL8w5LSSsnlMzZgu+D?=
 =?us-ascii?Q?pbGaRX+GDvFOGccnV2El+8b0MsHFhuQTsXyBZro6gxq3DadGwMUkwxjSWPL+?=
 =?us-ascii?Q?BKyPHY8dduRu3arXZwlm5wQG1LpDPWmo2/ym1KvQUQUdM8TD11DHhKP3YYNO?=
 =?us-ascii?Q?RCfvIHo4cLretc90gJ5qI/aUoIxeoVyRGmqD8sC2qUPhQzBdjJNxRn4zj5Nc?=
 =?us-ascii?Q?lWlqwXHzZCShXEjPZIrtA8A5+DqdlA37DgDPZu25LL78SRrI5ZsHA2GieJF6?=
 =?us-ascii?Q?tdbSJgY2wAMkJvnjuQdIFIYc/V3/mjaxySZZ5/Of7RjrCXTeSZKuGrjdTymp?=
 =?us-ascii?Q?tYIbziLufk02UyF7O90rxWGgREKC/Ca2bQzXEGmcT3+h3Pr/KM9/BwmaS31t?=
 =?us-ascii?Q?K23drfz2O62iiOr4sDyD9geqxjQWdN0SsuljY6c9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c776267-316e-4a3f-140b-08de33720801
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 20:16:38.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Syk0cjQwWB91m2NA0r2GlD/fWkpjULmEWwuX5cCNGKfzw1VY/bkWD71xBBJz3mmt65o12icDb6BhAUVBfyqgDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8470

On Fri, Dec 05, 2025 at 12:42:03AM +0900, Koichiro Den wrote:
> On Wed, Dec 03, 2025 at 11:14:43AM -0500, Frank Li wrote:
> > On Wed, Dec 03, 2025 at 05:53:03PM +0900, Koichiro Den wrote:
> > > On Tue, Dec 02, 2025 at 10:42:29AM -0500, Frank Li wrote:
> > > > On Tue, Dec 02, 2025 at 03:43:10PM +0900, Koichiro Den wrote:
> > > > > On Mon, Dec 01, 2025 at 04:41:05PM -0500, Frank Li wrote:
> > > > > > On Sun, Nov 30, 2025 at 01:03:58AM +0900, Koichiro Den wrote:
> > > > > > > Add a new transport backend that uses a remote DesignWare eDMA engine
> > > > > > > located on the NTB endpoint to move data between host and endpoint.
> > > > > > >
> > > > ...
> > > > > > > +#include "ntb_edma.h"
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * The interrupt register offsets below are taken from the DesignWare
> > > > > > > + * eDMA "unrolled" register map (EDMA_MF_EDMA_UNROLL). The remote eDMA
> > > > > > > + * backend currently only supports this layout.
> > > > > > > + */
> > > > > > > +#define DMA_WRITE_INT_STATUS_OFF   0x4c
> > > > > > > +#define DMA_WRITE_INT_MASK_OFF     0x54
> > > > > > > +#define DMA_WRITE_INT_CLEAR_OFF    0x58
> > > > > > > +#define DMA_READ_INT_STATUS_OFF    0xa0
> > > > > > > +#define DMA_READ_INT_MASK_OFF      0xa8
> > > > > > > +#define DMA_READ_INT_CLEAR_OFF     0xac
> > > > > >
> > > > > > Not sure why need access EDMA register because EMDA driver already export
> > > > > > as dmaengine driver.
> > > > >
> > > > > These are intended for EP use. In my current design I intentionally don't
> > > > > use the standard dw-edma dmaengine driver on the EP side.
> > > >
> > > > why not?
> > >
> > > Conceptually I agree that using the standard dw-edma driver on both sides
> > > would be attractive for future extensibility and maintainability. However,
> > > there are a couple of concerns for me, some of which might be alleviated by
> > > your suggestion below, and some which are more generic safety concerns that
> > > I tried to outline in my replies to your other comments.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +#define NTB_EDMA_NOTIFY_MAX_QP		64
> > > > > > > +
> > > > ...
> > > > > > > +
> > > > > > > +	virq = irq_create_fwspec_mapping(&fwspec);
> > > > > > > +	of_node_put(parent);
> > > > > > > +	return (virq > 0) ? virq : -EINVAL;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static irqreturn_t ntb_edma_isr(int irq, void *data)
> > > > > > > +{
> > > > > >
> > > > > > Not sue why dw_edma_interrupt_write/read() does work for your case. Suppose
> > > > > > just register callback for dmeengine.
> > > > >
> > > > > If we ran dw_edma_probe() on both the EP and RC sides and let the dmaengine
> > > > > callbacks handle int_status/int_clear, I think we could hit races. One side
> > > > > might clear a status bit before the other side has a chance to see it and
> > > > > invoke its callback. Please correct me if I'm missing something here.
> > > >
> > > > You should use difference channel?
> > >
> > > Do you mean something like this:
> > > - on EP side, dw_edma_probe() only set up a dedicated channel for notification,
> > > - on RC side, do not set up that particular channel via dw_edma_channel_setup(),
> > >   but do other remaining channels for DMA transfers.
> >
> > Yes, it may be simple overall. Of course this will waste a channel.
>
> So, on the EP side I see two possible approaches:
>
> (a) Hide "dma" [1] as in [RFC PATCH v2 26/27] and call dw_edma_probe() with
>     hand-crafted settings (chip->ll_rd_cnt = 1, chip->ll_wr_cnt = 0).
> (b) Or, teach this special-purpose policy (i.e. configuring only a single
>     notification channel) to the SoC glue driver's dw_pcie_ep_init_registers(),
>     for example via Kconfig. I don't think DT is a good place to describe
>     such a policy.
>
> There is also another option, which do not necessarily run dw_edma_probe()
> by ourselves:
>
> (c) Leave the default initialization by the SoC glue as-is, and override the
>     per-channel role via some new dw-edma interface, with the guarantee
>     that all channels except the notification channel remain unused on its
>     side afterwards. In this model, the EP side builds the LL locations
>     for data transfers and the RC configures all channels, but it sets up
>     the notification channel in a special manner.
>
> [1] https://github.com/jonmason/ntb/blob/68113d260674/Documentation/devicetree/bindings/pci/snps%2Cdw-pcie-ep.yaml#L83
>
> >
> > >
> > > Also, is it generically safe to have dw_edma_probe() executed from both ends on
> > > the same eDMA instance, as long as the channels are carefully partitioned
> > > between them?
> >
> > Channel register MMIO space is sperated. Some channel register shared
> > into one 32bit register.
> >
> > But the critical one, interrupt status is w1c. So only write BIT(channel)
> > is safe.
> >
> > Need careful handle irq enable/disable.
>
> Yeah, I agree it is unavoidable in this model.
>
> >
> > Or you can defer all actual DMA transfer to EP side, you can append
> > MSI write at last item of link to notify RC side about DMA done. (actually
> > RIE should do the same thing)
> >
> > >
> > > >
> > > > >
> > > > > To avoid that, in my current implementation, the RC side handles the
> > > > > status/int_clear registers in the usual way, and the EP side only tries to
> > > > > suppress needless edma_int as much as possible.
> > > > >
> > > > > That said, I'm now wondering if it would be better to set LIE=0/RIE=1 for
> > > > > the DMA transfer channels and LIE=1/RIE=0 for the notification channel.
> > > > > That would require some changes on dw-edma core.
> > > >
> > > > If dw-edma work as remote DMA, which should enable RIE. like
> > > > dw-edma-pcie.c, but not one actually use it recently.
> > > >
> > > > Use EDMA as doorbell should be new case and I think it is quite useful.
> > > >
> > > > > >
> > > > > > > +	struct ntb_edma_interrupt *v = data;
> > > > > > > +	u32 mask = BIT(EDMA_RD_CH_NUM);
> > > > > > > +	u32 i, val;
> > > > > > > +
> > > > ...
> > > > > > > +	ret = dw_edma_probe(chip);
> > > > > >
> > > > > > I think dw_edma_probe() should be in ntb_hw_epf.c, which provide DMA
> > > > > > dma engine support.
> > > > > >
> > > > > > EP side, suppose default dwc controller driver already setup edma engine,
> > > > > > so use correct filter function, you should get dma chan.
> > > > >
> > > > > I intentionally hid edma for EP side in .dts patch in [RFC PATCH v2 26/27]
> > > > > so that RC side only manages eDMA remotely and avoids the potential race
> > > > > condition I mentioned above.
> > > >
> > > > Improve eDMA core to suppport some dma channel work at local, some for
> > > > remote.
> > >
> > > Right, Firstly I experimented a bit more with different LIE/RIE settings and
> > > ended up with the following observations:
> > >
> > > * LIE=0/RIE=1 does not seem to work at the hardware level. When I tried this for
> > >   DMA transfer channels, the RC side never received any interrupt. The databook
> > >   (5.40a, 8.2.2 "Interrupts and Error Handling") has a hint that says
> > >   "If you want a remote interrupt and not a local interrupt then: Set LIE and
> > >   RIE [...]", so I think this behaviour is expected.
> >
> > Actually, you can append MSI write at last one of DMA descriptor link. So
> > it will not depend on eDMA's IRQ at all.
>
> For RC->EP interrupts on R-Car S4 in EP mode, using ITS_TRANSLATER as the
> IB iATU target did not appear to work in practice. Indeed that was the
> motivation for the RFC v1 series [2]. I have not tried using ITS_TRANSLATER
> as the eDMA read transfer DAR.
>
> But in any case, simply masking the local interrupt is sufficient here. I
> mainly wanted to point out that my naive idea of LIE=0/RIE=1 is not
> implementable with this hardware. This whole LIE/RIE topic is a bit
> off-track, sorry for the noise.
>
> [2] For the record, RFC v2 is conceptually orthogonal and introduces a
>     broader concept ie. remote eDMA model, but I reused many of the
>     preparatory commits from v1, which is why this is RFC v2 rather than a
>     separate series.
>
> >
> > > * LIE=1/RIE=0 does work at the hardware level, but is problematic for my current
> > >   design, where the RC issues the DMA transfer for the notification via
> > >   ntb_edma_notify_peer(). With RIE=0, the RC never calls
> > >   dw_edma_core_handle_int() for that channel, which means that internal state
> > >   such as dw_edma_chan.status is never managed correctly.
> >
> > If you append on MSI write at DMA link, you needn't check status register,
> > just check current LL pos to know which descrptor already done.
> >
> > Or you also enable LIE and disable related IRQ line(without register
> > irq handler), so Local IRQ will be ignore by GIC, you can safe handle at
> > RC side.
>
> What I was worried about here is that, with RIE=0 the current dw-edma
> handling of struct dw_edma_chan::status field (not status register) would
> not run for that channel, which could affect subsequent tx submissions. But
> your suggestion also makes sense, thank you.
>
> --8<--
>
> So anyway the key point seems that we should avoid such hard-coded register
> handling in [RFC PATCH v2 20/27] and rely only on the standard dw-edma
> interfaces (possibly with some extensions to the dw-edma core). From your
> feedback, I feel this is the essential direction.
>
> From that perspective, I'm leaning toward (b) (which I wrote above in a
> reply comment) with a Kconfig guard, i.e. in dw_pcie_ep_init_registers(),
> if IS_ENABLED(CONFIG_DW_REMOTE_EDMA) we only configure the notification
> channel. In practice, a DT-based variant of (b) (for example a new property
> such as "dma-notification-channel = <N>;" and making
> dw_pcie_ep_init_registers() honour it) would be very handy for users, but I
> suspect putting this kind of policy into DT is not acceptable.
>
> Assuming careful handling, (c) might actually be the simplest approach. I
> may need to add a small hook for the notification channel in
> dw_edma_done_interrupt(), via a new API such as
> dw_edma_chan_register_notify().

I reply everything here for overall design

EDMA actually can access all memory at both EP and RC side regardless PCI
map windows. NTB defination is that only access part of both system memory,
so anyway need once memcpy. Although NTB can't take 100% eDMA advantage, it
is still easiest path now. I have a draft idea without touch NTB core code
(most likley).

EP side                          RC side
             1:  Control bar
             2:  Doorbell bar
             3:  WM1

MW1 is fixed sized array [ntb_payload_header + data]. Current NTB built
queue in system memory, transfer data (RW) to this array.

Use EDMA only one side, RC/EP. use EP as example.

In 1 (control bar, resever memory space, which call B)

In ntb_hw_epf.c driver, create a simple 'fake' DMA memcpy driver, which
just implement device_prep_dma_memcpy(). That just put src\dest\size info
to memory space B, then push doorbell.

in EP side's a workqueue, fetch info from B, the send to EDMA queue to
do actual transfer, after EP DMA finish, mark done at B, then raise msi irq,
'fake' DMA memcpy driver will be triggered.

Futher, 3 WM1 is not necessary existed at all, because both side don't
access it directly.

For example:

case RC TX, EP RX

RC ntb_async_tx_submit() use device_prep_dma_memcpy() copy user space
memory (0xRC_1000 to PCI_1000, size 0x1000), put into share bar0 position

            0xRC_1000 -> 0xPCI_1000 0x1000

EP side, there RX request ntb_async_rx_submit(),  from 0xPCI_1000 to
0xEP_8000 size 0x20000.

so setup eDMA transfer form 0xRC_1000 -> 0xEP_8000 size 1000. After complete
mark both side done, then trigger related callback functions.

You can see 0xPCI_1000 is not used at all. Actually 0xPCI_1000 is trouble
maker,  RC and EP system PCI space is not necesary the same as CPU space,
PCI controller may do address convert.

Frank
>
> Thank you for your time and review,
> Koichiro
>
> >
> > Frank
> > >
> > > >
> > > > Frank
> > > > >
> > > > > Thanks for reviewing,
> > > > > Koichiro
> > > > >
> > > > > >
> > > > > > Frank
> > > > > >
> > > > > > > +	if (ret) {
> > > > > > > +		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
> > > > > > > +		return ret;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +
> > > > ...
> > > >
> > > > > > > +{
> > > > > > > +	spin_lock_init(&qp->ep_tx_lock);
> > > > > > > +	spin_lock_init(&qp->ep_rx_lock);
> > > > > > > +	spin_lock_init(&qp->rc_lock);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static const struct ntb_transport_backend_ops edma_backend_ops = {
> > > > > > > +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> > > > > > > +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> > > > > > > +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> > > > > > > +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> > > > > > > +	.rx_poll = ntb_transport_edma_rx_poll,
> > > > > > > +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> > > > > > > +};
> > > > > > > +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
> > > > > > >   * @qp: NTB transport layer queue to be enabled
> > > > > > > --
> > > > > > > 2.48.1
> > > > > > >

