Return-Path: <dmaengine+bounces-7450-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BBDC9A3C9
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB8E23406B5
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745E2FFFB5;
	Tue,  2 Dec 2025 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="guoMYNg6"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010039.outbound.protection.outlook.com [52.101.229.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8C2FE060;
	Tue,  2 Dec 2025 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656632; cv=fail; b=Wf1DmSbhSou44YvxtqrIeycfUvxI+y/OYVBEOyT4p91hAHu0CNjEHAJkAraLHr9hETumXLgGDbKELSP/8hJiLguUw5EAuXDpXKABvYD6gXbAlSFREw32ZLHRVm+Bhkd197OGUQ6+MwKelkhDIfRLRtv0scz28Dhc2cOjcXQS5d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656632; c=relaxed/simple;
	bh=WQRD4RCG63psFONVMgevB1YZ4IDbNuLB/Y/lbZA6c4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MS/k5uVSjotTH4pFfN1Y6okpgrMYpmvx5gkCfrxWnz8ZGrtsfV+pPecYB1cVPvNC7h1IAC9FyONpahW50synAEQqhL6qbMvpxybIr9KTOmRQjaT/Rk2hRCfjbOOy4R6SvibIKGflPawF44osCdDJCblVZGtUCjXteK2f10forrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=guoMYNg6; arc=fail smtp.client-ip=52.101.229.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtN/ngmOXCqYlJDVVaxKgiK0Su/24DMS1JwxK1P8V2BGFNRrwowaQBUug5n8JrDsnDZEx9Zzwh9MjlJxqhPQ9Pt+kGGHf+NJ7SCOisiMmSNNmuzvbjBL4v6Zx31RSNvG7pKZ1bwcQ7v2BHiD/hWaagXBAC4FvXaM/UaWAVXA7r59YdbTIo0Lhnk/TiJ6WsHC6EpeiAhuzpcWZFddC37nzQmosw666PQ+z++g3IWMJufAEM9VXEfHrqCygUKsHwlsJCMtUXc1oLm6nNLdkWMxqpKATOph2A2jYmEHE8G26hV3sB7QM845a1nOZnu3ybi4OFMmnDC/xppsLlJzMJWd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh/LbDyJwhxh9DGdQvx+pftiigucvUICkWONQyL/oyc=;
 b=l+cvTQWi6Sge+1R8o6qNmyq7TLGj98UKFJ5nyFFb25VQw6tOW787nGGruq1uHSB7Wqwc3tUnRYTOq7Xa8MZGB/ObhgCKK4T5PUbZcK++CzsGKuXL870t57YJhPJK8gL6xorPEfefOx2KIho/Hbu4UgiVUGUbgpjvxSGpk3hsNmLHvhhhUMNhfYINQ6aSe1+QBtrger5zFvIauC1YKkQznk7P6qK1COebV74ZCnad7TFjpxf2tAR08Qvm+laxYEJ4vq2Sle9NSIYevVq9/Cq7FfU0JyQThMtsnlXmuieHuFAMLEZ3MjCCAXFWhQS61bH50D4O7rW5Wcs5n1AknsPlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh/LbDyJwhxh9DGdQvx+pftiigucvUICkWONQyL/oyc=;
 b=guoMYNg6a5GS5XbidfVvxoRvj3/XEuiDPuHOoypAdMcC5SmbGgYGEDd1FkMHUl44QWZYYnFjJV3GxG9vu1XbAM5rPZ3mPS5hR0OFeA7G8zuM7COT4EoFOhhayL/78zYQpsA2Ui2IzQRI3KM5GviPq6SSzapmGzs4qyhg+fPby6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYTP286MB4024.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:185::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:23:49 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:23:49 +0000
Date: Tue, 2 Dec 2025 15:23:48 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 03/27] NTB: epf: Handle mwN_offset for inbound MW
 regions
Message-ID: <dwejbrb2ow7l2q3ndtiwvffzipiog3ebe3pgzccyt3662s6yrk@mxag5rmqopkn>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-4-den@valinux.co.jp>
 <aS3o+6y0WTyeuE5r@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3o+6y0WTyeuE5r@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYTP286MB4024:EE_
X-MS-Office365-Filtering-Correlation-Id: f727902b-09d4-4c6b-de5b-08de316b5af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/pLj9WPqDLQA5QRY5yd75KZ3zUZNp2rbsYdzrwZbz0H3yLTdRYlJ67AcIOYm?=
 =?us-ascii?Q?KHfeVLrqUiLw5dSjUcimqL5ij7khfJPtfY9BigaxWO7es9c7jDRtMzqznyOH?=
 =?us-ascii?Q?ADF/rRBeRTDipVXD92gLTZBXLAkbseESVI42/oVS2RdizNLIJ4R3GBFalpvJ?=
 =?us-ascii?Q?vx5QGl+tCT6mtp2bCxPmDVnddis0B6tb4ByuXzsh2b3JZfDM1LpI2u/Un5m1?=
 =?us-ascii?Q?WZUJUfBACTKTV9JsFd0j9rFeYp4kV7G3EiwDJA1oY811OMXSBh3Wx6ZLLrV7?=
 =?us-ascii?Q?LxQhpiNcc7QP3oAwN8wXKQ9R8UoK7JLP/AX7Trgdl/z4FOCooYGs1h2MEJui?=
 =?us-ascii?Q?Xw8nXCDDftzxkIcocV+wbiyHOtQ1pC6zUQm8yF9QfYTYPqzcmiWlzCxo04lg?=
 =?us-ascii?Q?0zXoOnBDIRFTQ1v/OeuSvv2PELUfEl5VkMH1yTNexTBVMPuKKsS05W1FURmE?=
 =?us-ascii?Q?LoZ0v3FCgvhBRiQVybvd7YLB8xa8jh0KFafuY7SCpKxmn7yQzDdqt0yNQhXK?=
 =?us-ascii?Q?e2hZQavI9KvXtPVVi7Uz/mrimwtWXbAajeFvLHe7KjPgj+QC22NTPeXiAY8P?=
 =?us-ascii?Q?s1SLM7LTx7dEQlGj7qZLG5fnjoqFhtRhL2Bha5mxkoLREFLV8oUmxfeuUz+F?=
 =?us-ascii?Q?taRrBhGOgRtM76M0euGOJYxasEDHsVpLEWbEzP9z2SI0j7PwdL7qe/TCsYMV?=
 =?us-ascii?Q?sP7S7Grbw8H2pGQT3zDKjHglwiYtf8ztTsLrLwLgRgEF6ilSTN6bsuH+NobM?=
 =?us-ascii?Q?HXpz9CIQlTQvWGUFDepaXNrYC9hLBY8vuwqJOQpeSVSU9NtR/nvCqS+yk6Pb?=
 =?us-ascii?Q?N1p5KWDWurmYpW4SlFjmXo4KaYgBST54fBhQxQtdG8eTzp/yI7kBeW27gjGo?=
 =?us-ascii?Q?cP3KcI5fMzAAo7heKhQ2v2EiHPXcCECTBJIvOvtPlGo/8FZ3QtoE35LsMse0?=
 =?us-ascii?Q?74tr0omiuKsG5mmQKJkpAGLxcZ+m4IqXNQTLfbRc8Gl6N08GV6AGJeqlxavV?=
 =?us-ascii?Q?68FtYN+ogAOpZtLBViPUgqoiF/fAuWdYz25hz6anUMOeRNTd3QixqY1YKOY1?=
 =?us-ascii?Q?KJvNOq8EiRuMRTBBJt66gUzMRTqeW4sKGL5idaWXAj6rl67f6uyorXT6JLEQ?=
 =?us-ascii?Q?rQFnar9U9oQRoiB9aVfzaBCbBVIy9st/LOdpKuBLR6iij/tAaL5GPHV1eIWK?=
 =?us-ascii?Q?bfSgY8cE12Fjzn2KTF660xTT7qbtXOWI+4oiLJYOCqzRLI720Kug/W5/G4Hv?=
 =?us-ascii?Q?jgbS7uAskjf8Etsbu4ITQ8PmrKQpnyebn7eBfAwSdMNMzERuq/TYxp4VPvGL?=
 =?us-ascii?Q?M1GM8cibWRV4sbnlHtW2nkoL271njsZEx7J6GxWXSwKc4p9lTIuhD/r6QcF1?=
 =?us-ascii?Q?JcLk92bIDY+rpCmCT2ymVE14kTQzYLjcvRknfn4kXA6pxv5yI7cBAZewLyH3?=
 =?us-ascii?Q?iN8Lc/JyxlGoU018kYwmgrSLJPj6TZOc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2MLA3sFBZM9EzEJi10nsiJITI6C5pXXxwMmprm7jJuyceuaROcsFpGgUG33k?=
 =?us-ascii?Q?lR99+/5p3nDAWMLa2bywv7e5VjsZJ4BEVXqRhOPW+5IF6hvK3siknoQpA1CC?=
 =?us-ascii?Q?hvhzt4s80St3V/qmVlODqPlumwcZjus6JweRFbPl3Oq8w/ATYK52loznlrvC?=
 =?us-ascii?Q?ZaxaBD7dIqh6sl/3ofAM1TQtrGPYgFWFWJAtYEuUkLl7omQ7UYutfcnK8l7s?=
 =?us-ascii?Q?+rVBTHD8a89ioPkPU8shOffv/yx0XEUO7Tvt16k0FMbwdCn7bAjeWMQAUjgU?=
 =?us-ascii?Q?dOtQCSIIUZgIScnL1UxpqWjs9NR8UtoHnVaINoKdu1k8TTKY/J0hW0Ze0tsb?=
 =?us-ascii?Q?+4uNsX1BSEm+lFKoZISVXxaATJuf9+K9mGtdqgRrPJOOoEmOSv5OjwyAfDSW?=
 =?us-ascii?Q?NXNbVJCt/Vx5MZkquUS5svcAzc2nWe3ZAvBNAkkjxwasXRZ6j+EKKWW+xN7V?=
 =?us-ascii?Q?S9f60fJpVMSiA9U64LwtIL5z7Ftf89WT5DAYEDbyApYO3Rzt3nkcnPOdhnxS?=
 =?us-ascii?Q?P1cLURM3JbABPkwEVRSq+x6asldnS9wEOQpRbpbs/UzszcSDVK8wCQPvlCz4?=
 =?us-ascii?Q?re6fikdUITOBlCsx/9bBiZY/yZHxyDoQuhxpybGe2mcpKmSK1TJAPRewcvxK?=
 =?us-ascii?Q?ZR+jRtwxpboiSFmEQOuHVAXe6uD+3EwtgROYA4lv6EIukO7mAcBWHtoH6rI0?=
 =?us-ascii?Q?qudmgoDI8AEUWTCFCn2QNSOIckE+OCeqjSdYKj9+Om1mE9+ctyGZFKwROi/R?=
 =?us-ascii?Q?szBzYkbER4GI4jHOv+W8qe8oAY6QMkVwKHaVcURNbaEsBELnd03+XGmk/I1e?=
 =?us-ascii?Q?1ZXOYb75iCG7PUv4YCfQCBl5/j/Rr9eVa0bxdgIbF8BOqsTmGdIQOcRU/4pa?=
 =?us-ascii?Q?nIA3LInJ4rVFjUZ0AeAzsOAD3PnYRofYAB4Tt6JYZix7TIBxif9MMBdwu+l/?=
 =?us-ascii?Q?IMWaQIE0WtXUhOt9R3Q5qWd0HxMoe0WSZrDQHCa6StF7kPJgly57IWRO5r1T?=
 =?us-ascii?Q?IDrjXxailirGQTsl3sH7K5SbmQiBp8TjrdOBOCDHq2Rt+HkWqemmgejpthx8?=
 =?us-ascii?Q?X2eZf7Gf+MWd3mww8+0Zz4hYerM9OGxP0aLwsChHveCiapKwMiUZ4KIPifH9?=
 =?us-ascii?Q?PAR1ziVB3hXDzSqgXurw2hFNOBxvJkeLSE2+kHjER5H3B3E5/vMn7W/1U5DK?=
 =?us-ascii?Q?XSB8pGQ40z0b9JHLJl8tQdrVPXkVMqMQK2PXeAuzp0RNlfShsoBN6DTyE4BG?=
 =?us-ascii?Q?Yj/+unqEYksHkEAAbB8IpAE+oZZGeICmKmRT5xJ9Jej8wOJfsnah7hrjpGEz?=
 =?us-ascii?Q?6o72vhzyour7mfsTbABakzMvwvkWrz6BCbuu08iQwM5EWzzZSlc1fzpfjUtr?=
 =?us-ascii?Q?fRiWXkgSsRdVTvEbGcZGWvdEUwW4m/bhjDsY4kGoOH3eG6N6fvOMszSOh1/0?=
 =?us-ascii?Q?8zIy8aAJFV2yNiD5X7OvYJxbKm88vz+1EAwmGCIYVOvs4ipx4aN3aIyH8gnr?=
 =?us-ascii?Q?dzO1RAeDU5ToT/21lxLTVCmEfP/aOV0EaaaG7ct0sHrZQWlyaFBtYta9Htid?=
 =?us-ascii?Q?402lR7pd+ZHA36QthzU97s3l6GxIqYUdsKMG5TZH833coK7Gv+IKc+FlWpC7?=
 =?us-ascii?Q?ND4v8+dgZ9HhiM8rCm/QMuY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f727902b-09d4-4c6b-de5b-08de316b5af6
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:23:49.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHp0KUiFnwmFd4i89cxUpUf4JsDnuzm7gU2l+CgWnWgMStzBeI9DM7KDZwcbVCc+HVP7+i8xNrxz9Qs0D2ATYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB4024

On Mon, Dec 01, 2025 at 02:14:03PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:41AM +0900, Koichiro Den wrote:
> > Add and use new fields in the common control register to convey both
> > offset and size for each memory window (MW), so that it can correctly
> > handle flexible MW layouts and support partial BAR mappings.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/hw/epf/ntb_hw_epf.c | 27 ++++++++++++++++-----------
> >  1 file changed, 16 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index d3ecf25a5162..91d3f8e05807 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -36,12 +36,13 @@
> >  #define NTB_EPF_LOWER_SIZE	0x18
> >  #define NTB_EPF_UPPER_SIZE	0x1C
> >  #define NTB_EPF_MW_COUNT	0x20
> > -#define NTB_EPF_MW1_OFFSET	0x24
> > -#define NTB_EPF_SPAD_OFFSET	0x28
> > -#define NTB_EPF_SPAD_COUNT	0x2C
> > -#define NTB_EPF_DB_ENTRY_SIZE	0x30
> > -#define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
> > -#define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
> > +#define NTB_EPF_MW_OFFSET(n)	(0x24 + (n) * 4)
> > +#define NTB_EPF_MW_SIZE(n)	(0x34 + (n) * 4)
> > +#define NTB_EPF_SPAD_OFFSET	0x44
> > +#define NTB_EPF_SPAD_COUNT	0x48
> > +#define NTB_EPF_DB_ENTRY_SIZE	0x4C
> > +#define NTB_EPF_DB_DATA(n)	(0x50 + (n) * 4)
> > +#define NTB_EPF_DB_OFFSET(n)	(0xD0 + (n) * 4)
> 
> You need check difference version for register layout change. EP and RC
> side's software are not necessary to run the same kernel. Maybe EP side
> running at old version, RC side run at new version.

That totally makes sense, I'll do so. Thank you.

-Koichiro

> 
> Frank
> 
> >
> >  #define NTB_EPF_MIN_DB_COUNT	3
> >  #define NTB_EPF_MAX_DB_COUNT	31
> > @@ -451,11 +452,12 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> >  				    phys_addr_t *base, resource_size_t *size)
> >  {
> >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > -	u32 offset = 0;
> > +	resource_size_t bar_sz;
> > +	u32 offset, sz;
> >  	int bar;
> >
> > -	if (idx == 0)
> > -		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> > +	offset = readl(ndev->ctrl_reg + NTB_EPF_MW_OFFSET(idx));
> > +	sz = readl(ndev->ctrl_reg + NTB_EPF_MW_SIZE(idx));
> >
> >  	bar = ntb_epf_mw_to_bar(ndev, idx);
> >  	if (bar < 0)
> > @@ -464,8 +466,11 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> >  	if (base)
> >  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> >
> > -	if (size)
> > -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> > +	if (size) {
> > +		bar_sz = pci_resource_len(ndev->ntb.pdev, bar);
> > +		*size = sz ? min_t(resource_size_t, sz, bar_sz - offset)
> > +			   : (bar_sz > offset ? bar_sz - offset : 0);
> > +	}
> >
> >  	return 0;
> >  }
> > --
> > 2.48.1
> >

