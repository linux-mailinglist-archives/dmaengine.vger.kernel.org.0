Return-Path: <dmaengine+bounces-7453-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774CC9A472
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B1E3A5ADA
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938C2FD7CA;
	Tue,  2 Dec 2025 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="iio3/ZGM"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010043.outbound.protection.outlook.com [52.101.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2222FFDF0;
	Tue,  2 Dec 2025 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656815; cv=fail; b=kZsGbX17VgUTGb/tWm16RtjEF6qvsBritUC0SfyEgwDxjm4Zn6LliPSK8XYkxfaXkqZrHqi3l7qjCMWiFvXQeP4gNWWTs5tKvvo1nEnlj85qdRdF4vbc0GX4K6MKz/DoqzOxVX2/tJp2+Ch8TMbqSlFIc/Ovgj5FGvhHeC8xDyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656815; c=relaxed/simple;
	bh=2xMGLCmREbMFubXJ/awciqncxx3n3UrFGpkmW9NGmGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lK33ZTnXWp1LjPqfNxCW8P8QRJf4VDect0lCzccvfWGlv7inyBxtQa6u1BI3cPtiFOIAgSFbOLeiYyLol119Us9F3qDdWmv4qrfGPgKCD8AHMtS3agl39d6wUTxxiPVDTPZoquqUD4Lq8rOLfwrpXK+vi7u0wUyyLgsyrI5/p1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iio3/ZGM; arc=fail smtp.client-ip=52.101.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLQXkfZGvA0DSw8b5Nc+Y7B/OeASBUwPAgSeYv3OMoyDPISZBWLjmiBNuZPaY3s/QiWcAt9LzIHO5L68aRiDZdOCT80DseEXLga90sRyblNKF637370Wl3XVJ3l9rJdo7WIedIMm2Shvw6WGeuNUh31RnPKGMyuBVR011TItIMQoZkHwv5CWzf/WUXKr0Nd8RfrwfikTRkur5fnVhmOy7IirFxHSSQ9dzty+fPh6xfR1iw+oxik7kBU2kaZt/9iQwGpUlGt1JVQ54cKfqE/vtTdC4cj2T4GExoMEawcgLjU813e/Ul3gsFBzkhwqLor4GnoNR4a93UOFr++IH4WLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb1if7kEOuRUeVTe8+CvwQxLUgig952IwSgJ683EIvI=;
 b=mZ0Eeq8Ym38MXhfU1re7s5YDQsAyW/+LkxwCAEyjdoZlhLEcPQr97zkU7ke1ot74U2K0jl/ZvcGb4LAM1rTGqQ2hV1QCaatBV6rAAknt2SfkbpqCyNbKgBHADSiH9PHy1qGeupV9kH4fuGR18p5jaqdM30gK6DMjUky39iqJNWafUCV/Ej1xnqXIcq6z65h26jbDdJ347aEBEqtoFx/zHeOsOphNjQm22VnMZqXvFG6nDpCEVqKzRK70O3O090/x9s8s6WDXVCJ1d0EEcWzeooCf48I2O1cg2H9W8X3uu6QLYRcWdoBYsUnvvxq1Gxo2w7Ba1av5DRRxxGPii6Pq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb1if7kEOuRUeVTe8+CvwQxLUgig952IwSgJ683EIvI=;
 b=iio3/ZGMcB/9uvNtCDM+2TCKmSQOmgwQEwCf00YKwSP0gnK7Jn6wluIJbSZ9pGIS3g6YM0kuw93peK7HalRW2rbn4MzeoCNA5a7AFZiVKG+Xy0txalwEJGI9MafrPXL/QIWcfxEU7YcNdPw0qpS69kPhUZUzksY/SRalE+frxd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY4P286MB7525.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:351::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:26:51 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:26:51 +0000
Date: Tue, 2 Dec 2025 15:26:50 +0900
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
Subject: Re: [RFC PATCH v2 06/27] PCI: endpoint: pci-epf-vntb: Use
 pci_epc_map_inbound() for MW mapping
Message-ID: <yvxxbc4jaury7i5x4qewgajra65y3gulmvuuxqktoozbcoy3pl@k46gz22j24zc>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-7-den@valinux.co.jp>
 <aS3tr2QVElXII3vX@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3tr2QVElXII3vX@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::19) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY4P286MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: c67b561d-9aa3-4411-19a9-08de316bc78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dp72UFU3KeTLIoo5wCx9n5w6zoSjWGFwbkjq+7Q3ISGlzuLZP/hAb07e4hp1?=
 =?us-ascii?Q?yVxAN+ebvFViFCCYPHbHXA56ucwfkSYJ6iFmKzACG/7fbr/LWy3UZPMC0/bh?=
 =?us-ascii?Q?fWfl09ZFqyUujIf6H10dzjWltHkmv8TDhEv0Z9gONrX9eIob3GUqUiff1yyH?=
 =?us-ascii?Q?+xJf4PKMOquvN4HHXws5Dt4T1HOi4gHocrdF+4iYrEGKX++737IlI3bYWZvm?=
 =?us-ascii?Q?CsCBpVmpEBepE0WlxNjUfCqgvPlN5jxn6e5Njl6F7DUpU5skOyPka2CrGn2t?=
 =?us-ascii?Q?Xp4bgXoqwlRuOngfiZKS2TVfukplExYLYUg7g9mnTxC/8dfiCxoiknkd8dRu?=
 =?us-ascii?Q?/0OD05DV/2dUg/QAlYLQIlLopTBMDN9aVlPekiM0HjoebIazdkdklPSXpQWr?=
 =?us-ascii?Q?EB7i0lVCd/OUuQe0xz6d687g528BnSH0ZahEO413pP5OpAO+Lkx+UbpbOqpR?=
 =?us-ascii?Q?3DSAvy9KqnkZI3k1KrlmJU/jAdu8ZwYviKqLBfIEmlJKLKpS2PbzB2fcXLOH?=
 =?us-ascii?Q?Yv5zxYheTBiGK5M1N4FCk5bMePGoyc/c2JFadfvSP6nkp26lkB/oQzJcSAS1?=
 =?us-ascii?Q?M8gBZj46bYr2ryMGw3KJgVXqeVhuMSgkf9XqWOht/Y7k413sL6xS4/cOI6Ah?=
 =?us-ascii?Q?VRdGzphIALcTpjmaxnxeOg2uA4Glu8ZfV1TblBvnrQwG06OLeRuc8MXvtzY5?=
 =?us-ascii?Q?9znKdR1TkOMP+ZsIFiY0ZGEJPvt8vtNcK4CsRzo5AsHRXIngBVXiSQfghxzv?=
 =?us-ascii?Q?8belx7rdu0eUh+M/nFMdCIcVSFgWPSscri2HAQ5IT7M8RMCGenOaiSrOp4/H?=
 =?us-ascii?Q?/weSwqNH2VJzagvv9YrRhIYbWiNYnzAhQ1VPJWBgc92t/TPknbqJz34DBAty?=
 =?us-ascii?Q?cdpnhORYb/Tq8ujORqVgPERFwoYXNjEFwoHhZBlDzDQvO/kIBmcscGhRQF1o?=
 =?us-ascii?Q?yxy4PysBNmLaLI+z4IsgI3hZw2yRrBbzkJ1sp4sjKD8otft6kf91T7zPpB8+?=
 =?us-ascii?Q?l7sDeDgFYdMfW0iGLzFQCZYoCYtNFeGMZWNzxVPiN2qAmlOYlkse26S5Oixp?=
 =?us-ascii?Q?626191MwY/tOiROB72WeTj8z8u8otuJkifnMzMQrl1c91UiU5CSXsEXkSszz?=
 =?us-ascii?Q?0VbxAu1TAMKXFKIeuWJUFlw/8lG1jfTvHQqq4IjSFGbp8oH0ynxWd1jHw4sO?=
 =?us-ascii?Q?cdZityTv0MviN0THXa77m+tLKyi6cSqB3/DflObHLt0A7nMmYqmefhg8NK0M?=
 =?us-ascii?Q?OdW5amjL8vvRnxI8IxiiAVnth5bwCw3FGHi0pMckjBsAEC+Y4Hk8j0AVAGYK?=
 =?us-ascii?Q?aId7oa9cs15dIxXzA2tXEoX121YYDHHdIfecPUyntslohe4j+6vl98CEmbKN?=
 =?us-ascii?Q?0DQu0e/2EDQgd2bjbtw1+luPhAt7gy1JuaWkNU2+F907/XyPnhKbqLgWqOWN?=
 =?us-ascii?Q?jcGdkRJz8jxzeLL2RhmV0MGZE0FV17Ar?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXj7W3uc3ISFpkq7Yo24fSJchHo0ari8BxGvbnSQfcjeZ3FPG+W/80CPFhhV?=
 =?us-ascii?Q?SIw5Wq1k70jzYgIRNQy6CA6yYUCaMMHBYyyLtTvPaWw8mnyqKgrLn1WOKg0V?=
 =?us-ascii?Q?GuhTjQ0Lr7zF4TFFBRhslSc9QeF2b7KC0O4r8Yw+VROMCd9q25CJ1tjq9SRj?=
 =?us-ascii?Q?Go2HCPyB0RgElNXXvBLYY8S7Clvl2mZcQgxSu0PsJ/i9YAApmXFF+PJUKlEo?=
 =?us-ascii?Q?hbZudfJtKQ1feyzW8BSNLVvG8V6rFATSqGik1yovr99F/DEceUwcrcy+kB+S?=
 =?us-ascii?Q?sAEe6rYzX/3j80Tyc8BQFPBGPQ5ENuYPi/GRkYXntN9tYvrcfPJFXvJx/hYZ?=
 =?us-ascii?Q?irgsmiHox492K7eTmElynAQ1gCqf10TEy/N/pv7d59UiVikL8Fc2cPR0MfvZ?=
 =?us-ascii?Q?VkppNEsr6Fq7WMZ5ZsNOf8kC+VnIW+W8nCdTNP0Ww7kPKqM+WYh2PC98d7t4?=
 =?us-ascii?Q?aLrg0qh8d83RKYywdmqztvTakjwhTyfIr+IifAuMV0r7ASDmil8uq+z9rv9P?=
 =?us-ascii?Q?JqhUWk6EQHZC1o7tvxaX4ssWpwGNmAUEF+Uh5rMbkSLm75+wpyvvUfqsUz0E?=
 =?us-ascii?Q?9UfSrg5byZHvdAa8N0/EANggMDhYe6Ld7Ay7Z/h2m5mHjdvppdO+AzC9X7ME?=
 =?us-ascii?Q?lDtw/Vf8wIeF8KH6UJ8GshPy04s7vXUYcaAYjU22eQsOtzLHCqPckrqSFxAF?=
 =?us-ascii?Q?ZLUDTtBf0/kwsa1lprLjzcvll86nsRs55L7Tla0YPGb/WA6pb3rVDLX7nsMN?=
 =?us-ascii?Q?klb6MMnudYurodJbQjSySM67XkH1WwxqsRISnYsOAvASIEzT9TsnSjRLYJKh?=
 =?us-ascii?Q?ECHxZwPdw0MMwG7jJNgMO+h8e/tCyEAER8bJg6jo19eaAC80vucJcNE2ITxD?=
 =?us-ascii?Q?iBmQ1lT5di8lmx9Q2G3A+QSS9nYhdb8HD/Smq8g4uN3L0Zm2RH1Gz8eR7E8h?=
 =?us-ascii?Q?89qMAhGPvOrQ6aHFYb8lFRd3KG79m3XS6lwWXLHRa7XezxONIF528+x4IUs2?=
 =?us-ascii?Q?JQm1M986xEJuS0YsogrJho4ephyP3NXamfBXU2336AwRUpZXKuIPYF/ZpWpV?=
 =?us-ascii?Q?De7InRcaRoaz4KyVL1oIeeEQszoA3KfKdnG74s5durbzfm52K1uYxAfryQLY?=
 =?us-ascii?Q?CJiFlIwOycYzA9ufcraDwdYhyyEaCm1CRZ1346lgELlU2cd20lkoSuRs0s/+?=
 =?us-ascii?Q?xEWdcaMcL1wlQyGvY8UoifC6wF3+YQRl06hOXJ4jhNTL+Yo4HYXhx64fJmwd?=
 =?us-ascii?Q?xFG4qPGq9x7wRmVPxoeS2N67gs8qkYwOrz8FR44oo2ujV2ghUErrvB99K+gB?=
 =?us-ascii?Q?FZ4D8CC3e7bvlhm3Hc41Fs0msv0YQ+APW766716IgUXFfgAJqgnx/AvgWHv7?=
 =?us-ascii?Q?JVy1eJzmM2wJuUrwieaNBD5ZO3mGmxMN0BeeA6ne2Ekxd4fZG6xPSd1vgD7K?=
 =?us-ascii?Q?HFtuZXehWO/QSHliSMJHGPYJ5XWun+C28EREZ/ZFIGkP/tkKndUejZt4QPBE?=
 =?us-ascii?Q?p20mzAFRcA9/Ds9WXOOrQhDafNxyJiCySxdoY29QzDRYLilhsOh3rIDVqaxL?=
 =?us-ascii?Q?YnUKLg7DshgVAO7vX0/MJAQ9q5w5Tj6D/rPdtSaZlBS6rnGA1XotFaozwznm?=
 =?us-ascii?Q?oISBLqd808gMlfhcokaAeKE=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c67b561d-9aa3-4411-19a9-08de316bc78d
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:26:51.3541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBcDjlZ+uzgoSKgC9b4UAFWxqbW2L2YqL/87fjoKGqGsJ1+mTTeweQIke2vCRohImbhzPJbw2cwQzTR64NWKow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7525

On Mon, Dec 01, 2025 at 02:34:07PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:44AM +0900, Koichiro Den wrote:
> > Switch MW setup to use pci_epc_map_inbound() when supported. This allows
> > mapping portions of a BAR rather than the entire region, supporting
> > partial BAR usage on capable controllers.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 21 ++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 1ff414703566..42e57721dcb4 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -728,10 +728,15 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> >  				PCI_BASE_ADDRESS_MEM_TYPE_32;
> >
> > -		ret = pci_epc_set_bar(ntb->epf->epc,
> > -				      ntb->epf->func_no,
> > -				      ntb->epf->vfunc_no,
> > -				      &ntb->epf->bar[barno]);
> > +		ret = pci_epc_map_inbound(ntb->epf->epc,
> > +					  ntb->epf->func_no,
> > +					  ntb->epf->vfunc_no,
> > +					  &ntb->epf->bar[barno], 0);
> > +		if (ret == -EOPNOTSUPP)
> > +			ret = pci_epc_set_bar(ntb->epf->epc,
> > +					      ntb->epf->func_no,
> > +					      ntb->epf->vfunc_no,
> > +					      &ntb->epf->bar[barno]);
> >  		if (ret) {
> >  			dev_err(dev, "MW set failed\n");
> >  			goto err_set_bar;
> > @@ -1385,17 +1390,23 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> >  	struct pci_epf_bar *epf_bar;
> >  	enum pci_barno barno;
> > +	struct pci_epc *epc;
> >  	int ret;
> >  	struct device *dev;
> >
> > +	epc = ntb->epf->epc;
> >  	dev = &ntb->ntb.dev;
> >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> > +
> 
> Nit: unnecesary change here

I'll drop it in the next iteration. Thanks,

Koichiro

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> >  	epf_bar = &ntb->epf->bar[barno];
> >  	epf_bar->phys_addr = addr;
> >  	epf_bar->barno = barno;
> >  	epf_bar->size = size;
> >
> > -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> > +	ret = pci_epc_map_inbound(epc, 0, 0, epf_bar, 0);
> > +	if (ret == -EOPNOTSUPP)
> > +		ret = pci_epc_set_bar(epc, 0, 0, epf_bar);
> > +
> >  	if (ret) {
> >  		dev_err(dev, "failure set mw trans\n");
> >  		return ret;
> > --
> > 2.48.1
> >

