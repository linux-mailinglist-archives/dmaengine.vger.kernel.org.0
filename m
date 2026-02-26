Return-Path: <dmaengine+bounces-9121-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0YWWAgatn2ngdAQAu9opvQ
	(envelope-from <dmaengine+bounces-9121-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 03:16:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1153C1A00E7
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 03:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F3FC3027C89
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 02:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B2278753;
	Thu, 26 Feb 2026 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="djV9672M"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020142.outbound.protection.outlook.com [52.101.228.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC225EFBB;
	Thu, 26 Feb 2026 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772072193; cv=fail; b=TX52cskz0B5RC4It+zLfJuh1CQT+9xopvtA1cevS5Zua+P+viRBeB9Eo6WiHVqOwPBaHujdf1zisKwh8gPHZzYhRoENlSk41+vUnrAt5mj1LJ47Yp61LErR6E3yJcczdosr81jA52MDeDHNGBvlt8GtFMhmil3LUiiDk/R0X0CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772072193; c=relaxed/simple;
	bh=+WjNG8soPWIBuWyArOWeg3ngZMLyjLMF7Vv2bTXjdiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=exYwWNY5oOgA/1+mOJhxX+11fbXLY3LAJVJsjN8HPbekSHwrP5Cs7gFSXko8Y+rwIQ2B0KcB7jORn7mT6G6CQDnwAyv3ujZth7+tZQTxFF559C23rcT7ElJO310US5LXeV1+bo3weTPb4xrBDNlezqNw6e1Z3T8c0M1e9FQs3CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=djV9672M; arc=fail smtp.client-ip=52.101.228.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrbztDVVI1nbDcIceqRzIMTXUpTZGW9jJrtJ2l37/wzrYRmfFqhpxYODyEh5xX/4T+1JEPJ5UjvwyAbuH1iPkUzsbxzMKu1fh6u5iXZ/Kqu0nf6t4MPBmg5Djw+8jAr5736gWepE5reW7w8hNn9s/rfH7B9xk432QwmFTbdUugh2MupWDOqiLpSUprBVIIkBZoWQws6D9WBOw5R2uo9llRjncjr/gPVe49g+0N9ERt6UFBrR8rV2hBqP+D5xtamQbadH10IT6olbNYfsJ7RVSZOFkcRSxrjoqvnzhD5MAttqKXxoE86eUXXBifYKnGBQfUeskaHuUK7O11McdVArDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK6gebS2zeWUFcgGCB0I453C4wArRfkhHizwF6BtE/w=;
 b=Nm1QpCGy4CnVFsMh7Cy+AMc7sPFiDrarBEkNWV9NF+UE+yLXIPn+5bqPovsvOq380MJiuRZLq7hr2GJYZPdwFCqJFlX+Sk9UGuD9xMXQ99j1vL7y9Z0TfyPUcswqe+Oi7SVCBIDwzTEQvtLlNVDw3jsdIO3VcCmxJPj9mv+1IuMamFRD1VNTOO/6QQd9p9w85TNlhEx6zcpn5Z0RUFa8aJO6hmiJ7CKJsE5r9SieF5krDI6Zv1dbvCaBbPXi8qaExPC1zfz7i/blRMWVzdpXv5i0e0jpaX2Na2Vd7NMdOgNVgpHtp9lSu4cDotvZZw8On2prFziLk9X+ClZnQBZwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK6gebS2zeWUFcgGCB0I453C4wArRfkhHizwF6BtE/w=;
 b=djV9672M97SZ4hgvw3/Sg9RHAQ/xP28fg57TbQjnzLMCRm/umLE9isA44GQwZJzMSQEomYpi30AA+oXOb94GxpP9QXXlEfEUZLnaOZRJ9Gmvin1RlNRXhWnG6vfHLNpHzYKufRFjn1b5h8YMTycGJEZ8Vg/JpGVixZpRUf1jJz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7487.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:454::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 02:16:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 02:16:27 +0000
Date: Thu, 26 Feb 2026 11:16:26 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 04/11] dmaengine: dw-edma: Remove ll_max = -1 in
 dw_edma_channel_setup()
Message-ID: <esdpmy46hffpg577hd67rxmpkfm3agrzrginegi2rczbwvdnlb@urqmwhh3kuff>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-4-5c0b27b2c664@nxp.com>
 <6d6c222faypvbo6fvs7tad2gtzxqqzlsjkrbefwmgxodt5thbc@lylpaqxozrg7>
 <aZ8YpKPqSjzDtomb@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ8YpKPqSjzDtomb@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4PR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:405:378::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ff1df6-341d-43f8-ddf8-08de74dd0c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	BAZ7/4nXzs77MFNpkQ7ovXc4f9tMpJAdqPvtUO8/oUPF5sKTb4em/DpMqSoVyidGMZb+WvTDMg0N3CtzQeW1bu5uvEBUF5nDKkyRhvQM7AgH7wvJVLqRfcklZaqCvNSE7OK0Dl8D6vqk4/FY7R6XDkDri+bMHMaQyfGJ+BxotEK4I4n3hidtovhKMylDfzDn2BlhuVr07uAbMqc/SGiM0dz2RvBZqnWByhSjPATNI9vvfygtig098ZegynOcDddJPdEhDHGi0OuVNt2p/Siztg4Sbff/rRNszzWoRx57UbgdsAXtiY9n3xrN4DwrYs9zo/FdLJrkW+g3k7mEoKlG/QwG5MhyOpsbst2CpwSe8yB0huDrHfCTqP7up1Vv/+u1p+JrX/JMYU7+9FTBMVPHeYKWmq/TMQYKZaOh443LD+m5CqsYqnNNAZ2N8F5z4WwMdC6lJgVp1XbJqOxrvSqwb7RVdyYGINY5NP7Xc7wEJaTC19vggBhHwxnEundx/hvRkHuOhOUsv1Kq1yN44sju0UhQTg31hEy9dtmB69+IWjINbpXgp5eABAd+DaxcbEDF5MdneiIv5cQBZpKzeBPZAy5CjzA3yiBmKaumn0a3Ibm1zRcGm6EAx0XAmLG8iIofxoHNmDbdkMbOuV/og/a1D9o64C+QR3ZfeA4UP33Wnlh9cr27XNRcwM288K9bI8mnjaxGpQtwLWXynwGlkHxxTlUUgCvbHTQFtB0A+N40g9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uWK9A1UIv7OMQR9/BKUu0g/RZSb4DJSMiWpG8Lrh+3YJeoebtyCOdO8IqDyk?=
 =?us-ascii?Q?rR1q8vFitH0x/5eNYbIiduRz9cvzGUoS+VOTPEJHDnLx15ME4YpTpezfRxeI?=
 =?us-ascii?Q?mLutfDredvVUQa6oP1xi8g9oZPNV5eSkvwm4kTNCZBySSw2UzH5aBvuXnwJc?=
 =?us-ascii?Q?+tIn9A6tuxBf4qJa5WoabZJIbb7CoeX2RfKgx/6BUM+S/1NW5PZ5w6+TzZ6J?=
 =?us-ascii?Q?y5LbIHCTbuVhacdKsC5tmCeLQAc9KJVBmWy7Fm3zARcahRoT3TcY6kIr3RTH?=
 =?us-ascii?Q?o+cOiI1exDIOPfrxg9CQ1RbbUaLQpi7TfFdyZN02rigow7paFnpekJW9DcZo?=
 =?us-ascii?Q?+7/0RS8RjU1Rv0mnsWAPwPfUTU562okzhxqFLu/zB3D12fGk2U7dQb4S3ahR?=
 =?us-ascii?Q?rhRi6anDFjZfbOpBYNKO/ouD7RZga6mHKV5ZjGjBZGMSVKE3MF7zwZzB/7sS?=
 =?us-ascii?Q?1wZjzWN6gCTZoknUjxnjGghM5TS74YsVQAsrpXxNTRP7viLATQQonMDqJfhq?=
 =?us-ascii?Q?YlUdKR194ZHJXFIvQvCnjEMd61NCRD6GQoDAehYxTfFwC3eVXG1XPitY2gyw?=
 =?us-ascii?Q?A+4+xRIlpMUlv4ee0EE5aFAlSs5yC2fjVNvxD6KYs5hKAHoWq6kgA1DahAn6?=
 =?us-ascii?Q?mIFCcB/0urxRYsfY2du6OaUuutZd0RKJVjb2XkYClJ5nGJnTFoP8zBklN0/O?=
 =?us-ascii?Q?42BorGWdy4nyxiqxRfM+ZK+VcGQvS6UB+qrmez68RpJtRvYt6RfFmXSVRJQU?=
 =?us-ascii?Q?rsifRAgdTQgQ8DXvvHGKi1oAB+/k2nQFfr7nAMGgPH6VdwIkmkKxmzWTeVw0?=
 =?us-ascii?Q?j4e5JweYBbhDpjiRRZ5pT7yW/UPqjCnGsBQ044jGQNeh6FIpxgYgwDPMUfvW?=
 =?us-ascii?Q?5WI3xLhif6Yh+/cpm1IsQv9P3idebVSMScF76pC5H3PGX0nsVBaBNcqZpSsn?=
 =?us-ascii?Q?Q4w83aC/opK1yw5Nuqa1fnhxHfEnk8qoy8L55kvQj9gsERILRvnGlRTm41cu?=
 =?us-ascii?Q?DsnJEBjKTRXylkCeiJlF4BrLNS8DYwiiuc0ndZZ/X+Q6VlZEF/vdK9/YP510?=
 =?us-ascii?Q?GPHbm2WFJMRHmqRjTyJqOi62sppF2tGS8DTceb+phBD9JI8ZxMVf8K1khpWz?=
 =?us-ascii?Q?ab/tXHBw8mhoDHjx/rEud6bAT/Q8Gd9pGfPwbXAuBCU3tv+5hBYshjXGBGDl?=
 =?us-ascii?Q?TG5Pg7laVUemrJWPuDo/h82SckXbe82PtGLE8vFlQs2Wyp6MzD9U65vqTlkR?=
 =?us-ascii?Q?taWkVN2LqbCGdMO5YMm+BC+ixi7ArfnjKudrZdW2/ZQjRyVT20PwDhWUzKLq?=
 =?us-ascii?Q?Uz6XCpcvTrY7m9j/nfzt82FOaUjHB4c2f2g3ro5cGlN9ujbtPPicw3ESV06U?=
 =?us-ascii?Q?0l+yfBV3X6qugaLqsyS32QYsrZT9hT+h70SHnU8WtJLYLo5VQm/EZYVGaF3A?=
 =?us-ascii?Q?j20kIQcG+w6/9eXE+xXYyW5cSaftCtsfzw+NiocLbkk35VtOd3isPKVtHVah?=
 =?us-ascii?Q?hnxQNPiX9gU3FIx3Q2sf12//eK9W1dl/j14ZbF4pha+1yGEyzsh6VlsqH7si?=
 =?us-ascii?Q?ZFt0hppcE7u9YrjT3FC4LVMBtzMZaOlMh1vaAGinp4UU4h+vPJX58bBANY8r?=
 =?us-ascii?Q?iJqWvkRPMCqOw5f4vZfK3fMrSp360avFrALruKvbtG/4fIJ6dai8Qn83Xiva?=
 =?us-ascii?Q?6NXD/AMMHjg3mUqCCdNjUXb/zIGp5V3WHA3gr/oelcrAfDne18OhhK8Tga69?=
 =?us-ascii?Q?IyXa4NK45SBKjWF9gE2ZzdsvI+7nyi/nzDfCz2glhbhzkxrc0mrB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ff1df6-341d-43f8-ddf8-08de74dd0c04
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 02:16:27.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD9UCa7jpB5/YXm89/Wc+B62oBvvLzIfjjzW8vWpU7yyfjmGTTEuSwPWqTlUsOghYuGPDUHLR+gvHzQYfnpu/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7487
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9121-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1153C1A00E7
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:43:32AM -0500, Frank Li wrote:
> On Wed, Feb 25, 2026 at 05:30:33PM +0900, Koichiro Den wrote:
> > On Fri, Jan 09, 2026 at 10:28:24AM -0500, Frank Li wrote:
> > > dw_edma_channel_setup() calculates ll_max based on the size of the
> > > ll_region, but the value is later overwritten with -1, preventing the
> > > code from ever reaching the calculated ll_max.
> > >
> > > Typically ll_max is around 170 for a 4 KB page and four DMA R/W channels.
> > > It is uncommon for a single DMA request to reach this limit, so the issue
> > > has not been observed in practice. However, if it occurs, the driver may
> > > overwrite adjacent memory before reporting an error.
> > >
> > > Remove the incorrect assignment so the calculated ll_max is honored
> > >
> > > Fixes: 31fb8c1ff962d ("dmaengine: dw-edma: Improve the linked list and data blocks definition")
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index c6b014949afe82f10362711fc8a956fe60a72835..b154bdd7f2897d9a28df698a425afc1b1c93698b 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -770,7 +770,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> > >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > >  		else
> > >  			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
> > > -		chan->ll_max -= 1;
> >
> > Just curious: wasn't this to reserve one slot for the final link element?
> 
> when calculate avaible entry, always use chan-ll_max -1.  ll_max indicate
> memory size, final link element actually occupted a space.

After the entire series is applied (esp. [PATCH v2 10/11] + [PATCH v2 11/11]),
yes, that makes sense to me. My concern was that before the semantics of
"ll_max" changes, this "-1" was required. In other words, this seemed to me not
a fix but a preparatory patch. Please correct me if I'm misunderstainding.

Thanks,
Koichiro

> 
> Frank
> >
> > Best regards,
> > Koichiro
> >
> > >
> > >  		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
> > >  			 str_write_read(chan->dir == EDMA_DIR_WRITE),
> > >
> > > --
> > > 2.34.1
> > >

