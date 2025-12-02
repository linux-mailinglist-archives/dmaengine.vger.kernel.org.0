Return-Path: <dmaengine+bounces-7470-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8140C9C00F
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 16:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43AA54E3E23
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8210830CD81;
	Tue,  2 Dec 2025 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="exx2fm2D"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3422A28BAB1;
	Tue,  2 Dec 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690168; cv=fail; b=Usvqv2CbpjKtPWuzKWB6f2FArt27unrXi2JmBDZRipo6BeDqHszl84JZ2fLQTABykaEISxExPcDh6uSCYfLp2sZf06NFuqGOoVH7vdmNmT3MXvpOlv2tl5Do/Uqv5oXEck9Ps9x50SlDAFBxNMQifX7NMHYqbO3NbbH5bmH6fy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690168; c=relaxed/simple;
	bh=ncxcYqP3F2FiLoKuZuBhV+vu/P83t4YfS+KL+WW6ZJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iCDj9RBCxreMCy85DNMSYJyodbS05ZXy0bn9vP8ublijn3FYgItDx1WXTPrfmadb7J1Ae7HOHFw95SGx/A1qNfaF0HVUGOI2hPtbmg9Rnal7v6OvJf1wt2ER/BlHoUrtqygEUwyEMM6dIxaTYzUnxGz9fdCCQC9HUXU+Ec9qxIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=exx2fm2D; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/3AQ8oP9CrPq7a+ENiJ3UvML9cYPJ4UBmWvWlXzsba9a1/Zh/V1Hohg//HxoyGJ4LbrV0NyL4AdjiT6mXa1WFZjMvNHjKXawwWHCSbclvYL4VTF48KEvP3L2OMQrkSAlAZWzEvQrGnhy4KYK0LVlqlzKKoMEDRi4jzg63VNgRc+Nrif5Lyj7kXN0fOTvoQZ10bB3Q3R7Dxqi5wcovYAjhfig0/QV1Qnp+Ooh6UnFnYBMUHTS7v3EMuQvuMd1TeoVL1d7rDcOi1uDxrnpoU575gXiHbx74vBOsYYJHmWWyO7bIdwI3ZoKtOsMTpMnhQksWU/1UzIsDXvHD+j/5wwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmZHj3brdFjcuMvtidHyK01WKq/LMEvQcmlv7d/lhxI=;
 b=e+sVUr14N7uL6phbM6F+p6CZRmz4ibmANbY9I1NLtwFoVZh4GZiUTWNKkXHEHn+TErY6RRd/BoQXOEo50Wm1RLRhPm69KFDWC3MO2pWNzrmpdtmMf+xjwWrCe+vdZsvJ3cZXmwsoKA7jH2/o26k4JlQmUH1WGrSg8Lyw9tf/6bXMQNo1eNDPW0RtfreAQc5hzoWAuLH1Rm1rc4ts4yDJS1DxxW811yo2sRYOTp1BR8sClpBUXAKjraz9EwH0YvcTCKB+sqCcbXc89qQSlUdXLF/G/O0ZU0PWBiZfHhfvjh7y59rQbM3BVZAIFzuMGzaC7h2yPCbHYiJOFI+5Y35r+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmZHj3brdFjcuMvtidHyK01WKq/LMEvQcmlv7d/lhxI=;
 b=exx2fm2Dm/+S8+fXalb+fcKKlmDHJSB1loafcCRJqq/koIBO+zSGk8oArhjM+lO5besL6CABLEBFaisztgY/qSMS2udWm7kFUc1kVPZjI7Ip4Tg7pSBnVYMJ44+ETBirWxAdRyG6go6eB9AFtccccc9CUqEvfT1KPeyXsPPA+IXbLetOYxJfqc4m7Q+D8NCrxb+bVPq+5q1Wd00V2FxdwdazEWLhTrCenWnNH8l1EUbdFN3DdkFZGISltVAF1mBnbdJWIEY3PJWb3D9k8EKfOOPrNkXxJZMDmyqpYY+MX0/M3xrZ+Qb0IUIhn+fyABGRjAeunaUd5Nf7WHNksZPapQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA6PR04MB11912.eurprd04.prod.outlook.com (2603:10a6:102:51a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 15:42:43 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 15:42:43 +0000
Date: Tue, 2 Dec 2025 10:42:29 -0500
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
Message-ID: <aS8I5e2UguQ2/+uU@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-21-den@valinux.co.jp>
 <aS4Lcb+BjjCDeJRz@lizhi-Precision-Tower-5810>
 <jiigiyxb2hllpeh3znbfy4octtubvkkrbxv7qfzzivimvz7ky2@i7b7a66peapf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jiigiyxb2hllpeh3znbfy4octtubvkkrbxv7qfzzivimvz7ky2@i7b7a66peapf>
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA6PR04MB11912:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6521bd-a8eb-48dc-f105-08de31b96eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wK7HawONcpMM/UOPd7OM/hSRi2qwKz0rQFwLAeaGxRgT4hf2Op+aIGzgg2Aj?=
 =?us-ascii?Q?Rk6/4IKuqkg+vx9EzRZo2WcIi8GbEe01SwiZw7yt1AbtcpN+0E2URZd+V54u?=
 =?us-ascii?Q?PHGDLqcFlIeF3aQI+Am+z6/sTwAmfJBSY+R8/4gSt1WE/HGvzZ9qtAIdbTsg?=
 =?us-ascii?Q?E+vqH60KOoHXWHr3h1NgITTB5ijhU7D5Ms3lyJCOfQ6HskOj//hMsPtBRWi8?=
 =?us-ascii?Q?td94V4Zcb3QO5SOeJDxOmCw9RPwue3EpKAtxXbfxVjviVSTIHbsc/6svYuRb?=
 =?us-ascii?Q?ysp5lsGkRCEkVqXXVip+AvgbUxPjftj9dliF+IFFsUahlOxJhoIGXlr5V7W1?=
 =?us-ascii?Q?scFahhsfGIyhDtnzd0efYgkL4S3Z3MiS8zvqDMmOwQbVY8zkHcMPx0WcSGRA?=
 =?us-ascii?Q?t3hZkWLzPWIfTo24aZN0d8EFYW+LXXsq2+1eeIDUERSzczQ7piIWAZ6QNQe1?=
 =?us-ascii?Q?NSXD2yhW8FXDIFCaOjZQrI9yYcVZ5G6RusmfeeEPuaFnPDi2EE9qLBj1YjSH?=
 =?us-ascii?Q?34WDP2OQC06RiZfM+40zvdQ1CaBkonxOTUF5pCLrFayhANN2k5agRjUdy+iu?=
 =?us-ascii?Q?+WTf0tFvjdEAtPGXmAeLjUInpCBMUu1iiYpAT7VbgCB8zldXReIO5DtTdjok?=
 =?us-ascii?Q?kawgNJuitTORGV+NWC8Txx6VOHFg9w+vCO8d0ZqBNKSju+A4u03s6YMg6RPJ?=
 =?us-ascii?Q?E5ffBfNm74tqUga3v0mZXpV8s49N+Ytj4H684+podJFvTe7CsrJKMt/N1x1Y?=
 =?us-ascii?Q?Pqm36crRcHoTEzdUgnpPNxGYfB+76HmZWymdVZqdg7VAt6WDCWSPorTjHxZR?=
 =?us-ascii?Q?JosVyLFpHSJyMEH93P4h7g73mQOGkIndiyPR3AUpybP9SZnjevpLtXg2FU+e?=
 =?us-ascii?Q?Yw5tJnybb/WnBrNhMFXqpeCaeuOUg7ZXoO5LJyInzxJbiE1WqVykf4F5qokq?=
 =?us-ascii?Q?vU6oKJ3URXS4IwB95Elya5mNvDd/f96ldIMc6xnZJDlp7QweA/yJCg3rdY9b?=
 =?us-ascii?Q?4EgdWheAnDS3oPuygAzh1ijwvPYlyGFphS0IjIVpyTROqCwpp404qENWHUki?=
 =?us-ascii?Q?pNNcWzt5LHPx44u00ULGi84/L+rPX/j255qEFcUSt++YUJql8amA3U+aJbHQ?=
 =?us-ascii?Q?S2M/vooMrawOaiiFZ87ZdozxUDgTFqar2TH4ZQAUEGDKVV5Jh51xy14a+zRM?=
 =?us-ascii?Q?CwJ3vSAh3l7Uy3C19XAhdHGMCRrTvOkOlQgBv8eb2DaiXE3pa74eZbMyGwmm?=
 =?us-ascii?Q?tWdHQRNYV0+chZHe0FRZNOxvPHmeVEG+K2Gx8iSvz5okfEJLaWAWdU+ctyQY?=
 =?us-ascii?Q?3M4gf2e6GcXJMbcAK8gAJu5vvfj6sepaG/A+/ItHvuYNruxprVrieUX/IIT5?=
 =?us-ascii?Q?OuiWs1mhP0lGhxfbdhOa+XN3JaRV9moGHT42M7ztmwDo3xAF4NOcQ1jnWUqT?=
 =?us-ascii?Q?YSXMcpe92SG89OeItvCfdVzoSHoKqBL9mUNUQW9Q+o9KpveVZHKb2tLX8YP8?=
 =?us-ascii?Q?3v6Ts0O8GTPcVLgr7Teqno+SBsXtuOBW0Zae?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QXDmRVIY0TtIcZ1Bla9Pp7BkmDfvm3GZy4ZK1kMJWFMq9sNAXK0RLsY6i0pM?=
 =?us-ascii?Q?DSJNzZbk0PU8guDw2d+H7ZIuyEnKCRrHVIYYNj7hcEDDORYZWnKcSmEH59lj?=
 =?us-ascii?Q?7xgG8k5DmO0iCUXyUYCI2pVAEBXnGBckV9kiEw5St5o9LR4bUD6Ogk1w5ClQ?=
 =?us-ascii?Q?p9nIefMtZHWtWF855FSEF98vq+CyglWEwu3VbBdSJ62SDb1uK+aIH5rQXFPH?=
 =?us-ascii?Q?UUcQEArjVtAgdVNINJAUrqu42soV9/fD++NbmDcydZRVOlmOWSoREuj2Pp2k?=
 =?us-ascii?Q?7PzN3/TC4R+B8dRQ2O6e/GEWIQtSKkTaDbav4+zLYsYXJ57sPgIlx7NpUY7k?=
 =?us-ascii?Q?meMEbIUiWzAoglYQ+6f8NOO0pYM2WDd+A9Bnojb4rM1fEE8eEo50Kv96cVUj?=
 =?us-ascii?Q?5lxY17m1MQBbsWWRtKeqj2OQSUVze8Nk831xj7eLVLo30WHJTTJadZklzY9n?=
 =?us-ascii?Q?Tbo+8t1bEEaF89goAG8YWX4Gk66QyuSD7U9Az4k9o0EOMG3/f/qFv735v6Z5?=
 =?us-ascii?Q?+fjGHk80e+4w1djfctitsX5GFNvl2MtHgiyXQ37Cf81KHZR9iFn/pVxjBAzS?=
 =?us-ascii?Q?kT4vsq1A/RmYihqxdGidxRkQzxA1RBVe48c/uo/hLzxP5+Zeur1QMUY1ZtW3?=
 =?us-ascii?Q?ATsHmHOavKzECnsZsh9no4S10xv8/LTnRq0GwohHQuDJWLxb+4CevJExWRTb?=
 =?us-ascii?Q?GE5T0B1RGm4ki8U7zw/tfIBs1zkpNx6nc4GURe2BwaU6CQDP85G9lpRTDy7d?=
 =?us-ascii?Q?vBXHv3e829KsEgIujRrpvuViek5UDnMoFJU6fZ/6AYtrPdVWCOkIWkr562E0?=
 =?us-ascii?Q?9oLL1GYmDrxBqmf8rA610S4V6161kdBEahN48UQ09+Z87b9DuTh5XubWtyvO?=
 =?us-ascii?Q?mqX7CKZKv7H+7qVLvAidEF6FQFNzxRZPD/c7zUwbYSRP8SgyHo+912P4e3uw?=
 =?us-ascii?Q?h5A4UnWmKpI+G/7/tBkuEXZ9RhClgqBxUWJwcQoLjA6NPruCroQW9KGDquLD?=
 =?us-ascii?Q?AwX7z0iPjpCKx8z3z1syo3UQ4scyRskIsXGloiJIR+vMHkAt8FYkIfA9s0Mz?=
 =?us-ascii?Q?+f7bRCM7D3wfxinaXVRkigMHQoYP8OAijnCaSmWleqLG6+//tiC55ZDmW0q/?=
 =?us-ascii?Q?3EKfLA7OCZE6tOQ2pjbyTAC71zB3VvacwkYRCO6l8j+D6U9AHJ0Miiti1xO+?=
 =?us-ascii?Q?o1+haskVULFlVKP4/uz9xanoSZuX7oXxliqhJMUKrhJZ7Z9c9866GrJYME6p?=
 =?us-ascii?Q?S13yrQmbb0BK9joudW9sIC9a3jNDL2i/89kWMzSwQpCTWdOqEtx2WaT1y/nw?=
 =?us-ascii?Q?NGzoZp24OkCA6xJ/bHngQNzGKdTf/xkkQMBZq8e7qwJFnYKYLNs4vljtpsy2?=
 =?us-ascii?Q?YYJ0pAE9PHOxFqxvIwwnHwYenfXEiXnmbevBQNwc4CjxKmbtMOrCrGpjFH9T?=
 =?us-ascii?Q?/G+7o7ucPJZvrAlyFl7MwTdAZFStUT6WZFWaapvNjpCz6lNr/oxzKFx1oHKd?=
 =?us-ascii?Q?bQuE/tVoMc07nubkmRocfHarZWWtzXOc9QEhzRivLcCBAHz/kBseYKazvA7G?=
 =?us-ascii?Q?Y7W3zw8c5xGV7pWby7WghPwbtkOzNbsJ/LhUYqQL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6521bd-a8eb-48dc-f105-08de31b96eac
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 15:42:42.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctMSe6AsfNKTCltTPCePZU+T0+39ifCVY5a5iASsGi0b4L++dC+sPUbQ6qUEBO9kWRZ5ed4wlD0GB/V8sd5M9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11912

On Tue, Dec 02, 2025 at 03:43:10PM +0900, Koichiro Den wrote:
> On Mon, Dec 01, 2025 at 04:41:05PM -0500, Frank Li wrote:
> > On Sun, Nov 30, 2025 at 01:03:58AM +0900, Koichiro Den wrote:
> > > Add a new transport backend that uses a remote DesignWare eDMA engine
> > > located on the NTB endpoint to move data between host and endpoint.
> > >
...
> > > +#include "ntb_edma.h"
> > > +
> > > +/*
> > > + * The interrupt register offsets below are taken from the DesignWare
> > > + * eDMA "unrolled" register map (EDMA_MF_EDMA_UNROLL). The remote eDMA
> > > + * backend currently only supports this layout.
> > > + */
> > > +#define DMA_WRITE_INT_STATUS_OFF   0x4c
> > > +#define DMA_WRITE_INT_MASK_OFF     0x54
> > > +#define DMA_WRITE_INT_CLEAR_OFF    0x58
> > > +#define DMA_READ_INT_STATUS_OFF    0xa0
> > > +#define DMA_READ_INT_MASK_OFF      0xa8
> > > +#define DMA_READ_INT_CLEAR_OFF     0xac
> >
> > Not sure why need access EDMA register because EMDA driver already export
> > as dmaengine driver.
>
> These are intended for EP use. In my current design I intentionally don't
> use the standard dw-edma dmaengine driver on the EP side.

why not?

>
> >
> > > +
> > > +#define NTB_EDMA_NOTIFY_MAX_QP		64
> > > +
...
> > > +
> > > +	virq = irq_create_fwspec_mapping(&fwspec);
> > > +	of_node_put(parent);
> > > +	return (virq > 0) ? virq : -EINVAL;
> > > +}
> > > +
> > > +static irqreturn_t ntb_edma_isr(int irq, void *data)
> > > +{
> >
> > Not sue why dw_edma_interrupt_write/read() does work for your case. Suppose
> > just register callback for dmeengine.
>
> If we ran dw_edma_probe() on both the EP and RC sides and let the dmaengine
> callbacks handle int_status/int_clear, I think we could hit races. One side
> might clear a status bit before the other side has a chance to see it and
> invoke its callback. Please correct me if I'm missing something here.

You should use difference channel?

>
> To avoid that, in my current implementation, the RC side handles the
> status/int_clear registers in the usual way, and the EP side only tries to
> suppress needless edma_int as much as possible.
>
> That said, I'm now wondering if it would be better to set LIE=0/RIE=1 for
> the DMA transfer channels and LIE=1/RIE=0 for the notification channel.
> That would require some changes on dw-edma core.

If dw-edma work as remote DMA, which should enable RIE. like
dw-edma-pcie.c, but not one actually use it recently.

Use EDMA as doorbell should be new case and I think it is quite useful.

> >
> > > +	struct ntb_edma_interrupt *v = data;
> > > +	u32 mask = BIT(EDMA_RD_CH_NUM);
> > > +	u32 i, val;
> > > +
...
> > > +	ret = dw_edma_probe(chip);
> >
> > I think dw_edma_probe() should be in ntb_hw_epf.c, which provide DMA
> > dma engine support.
> >
> > EP side, suppose default dwc controller driver already setup edma engine,
> > so use correct filter function, you should get dma chan.
>
> I intentionally hid edma for EP side in .dts patch in [RFC PATCH v2 26/27]
> so that RC side only manages eDMA remotely and avoids the potential race
> condition I mentioned above.

Improve eDMA core to suppport some dma channel work at local, some for
remote.

Frank
>
> Thanks for reviewing,
> Koichiro
>
> >
> > Frank
> >
> > > +	if (ret) {
> > > +		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
...

> > > +{
> > > +	spin_lock_init(&qp->ep_tx_lock);
> > > +	spin_lock_init(&qp->ep_rx_lock);
> > > +	spin_lock_init(&qp->rc_lock);
> > > +}
> > > +
> > > +static const struct ntb_transport_backend_ops edma_backend_ops = {
> > > +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> > > +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> > > +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> > > +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> > > +	.rx_poll = ntb_transport_edma_rx_poll,
> > > +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> > > +};
> > > +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> > > +
> > >  /**
> > >   * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
> > >   * @qp: NTB transport layer queue to be enabled
> > > --
> > > 2.48.1
> > >

