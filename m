Return-Path: <dmaengine+bounces-9425-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNkFKCrQs2ncbAAAu9opvQ
	(envelope-from <dmaengine+bounces-9425-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 09:51:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FF427FF4F
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 09:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F71B301A3BF
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEB235B64D;
	Fri, 13 Mar 2026 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JHkabu9x"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D51D555;
	Fri, 13 Mar 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391885; cv=fail; b=jWXzVPEX0no7e5JriqI/dFZNTztnOggHUcV8cb4LI1nGxYGVy0rDq8ogdebRxPhv8D2uE3tlTF9oXPE4AqnjjyAMzf/mLqhAu9qu3kr493JsNH1fr7x+ioTNF9aun/srSX+F8susvCPEZ4lgcTgPvgQ72vJxW3QIDiJf4PSP9KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391885; c=relaxed/simple;
	bh=Y9Ut85F98EEDq+KUocUgmtmiPh947LiNR8k2BTNIlWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fzIFUQ1eoosYVF/+SsxyWPSQXDFs4S7pSlPHJniDXaMqgQBfzbextg2n9ZwDlnVUcTbBnxIVuwnoHqL0vlbP8VqW+vKq/tGfisdKiK45CHgKDf5mwtLb4YiFw5SJ1rwQcavgkkXayXLgZVtZqLnC68Sk/REAXvV93pA4Yn46cok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JHkabu9x; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kh3BCmdiXCcVyYmtQ5f3JtU5/oIjTyy7LZ+/GAU28BimoTgGwkvXZrs5hQiv9uPfRlQbpZJKsH+lPohIjA6PUTcmAj6tuZUaZqjD8c3sTWmXd7n+H50tq4GfvJQsAGPIUz5KbvSxSpjd+eZAYlunnZBcEzR7UPAaV9GNxSbyH+h58qHUUYMTaJtbZdiyIJrPKBFKGwTynarWO8uAV0nAnPmU6wXa/ECllZdA9Cn0fyOWRF65N8EofauvI6Njc/S1aCke9nSB7azS+HhZCkvxLQpRlifFfr1C00J5EEDBLJ2PY1E3fFuxgC9ERobm9dvBKeROe3oMhNGjxiZFETj4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbV7LYszR+MfSQGsIg3Yi/MnzzI/1XAe0uT5fGY6eC8=;
 b=ncNDRMzhx3aXVChMhCW5ZFBi2OjTo4Yp0VoH5LR4cf+InHJPIciVtR48oKWOM5aTq4/UTDB1G6tYTUZ/43sMUdotsNbvrNw5f7VzNazlesav32adWgbd1rF06ZrDTQMv12CTjnQBIccmphGW/FPnBxGxYW+qRyUMrvTvvCJvj45dhJi7HhUjxBpoOnAIP+Qiy5MYh7UiaC9XduqFBgz/apHu6oopf4+hNNmrIgTk58VHV9VEScSyYYWZgG4sd3YN3z8cKLRGEOCEFQ2g8VQXiHCBXizd7fwpcENENkgkEgcCsELCjW3SDQr/QEycD4+tVXNcYK2ChuCvVJgx6NlC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbV7LYszR+MfSQGsIg3Yi/MnzzI/1XAe0uT5fGY6eC8=;
 b=JHkabu9xE3X1XPTpv9DVlkZwwXRs2ZlJAQGd9hLhP5CCaxwqTUZgoJxRKuMpsgNbI8V24xJQvLe3fkHaGH5qol+d+7MFTJdu5gICW74k173yUtxCNdRGKFk6xw1k1cWLqCdvhK4urRU1ezzPeYCzbFfKLfjLNzJdrUEEb9PlnOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2181.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:196::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 08:51:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Fri, 13 Mar 2026
 08:51:19 +0000
Date: Fri, 13 Mar 2026 17:51:18 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
	Jerome Brunet <jbrunet@baylibre.com>, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 01/15] dmaengine: dw-edma: Cache DMA channel IDs in
 dw_edma_chip
Message-ID: <lrrh43qyixskxsbjnl5v4252zcqnbqsngvdfmj62eyjdhmen64@pjdypxohap6m>
References: <20260312165005.1148676-1-den@valinux.co.jp>
 <20260312165005.1148676-2-den@valinux.co.jp>
 <abMcgQOHDD55Yv0e@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abMcgQOHDD55Yv0e@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2181:EE_
X-MS-Office365-Filtering-Correlation-Id: e37826d4-82c1-45b9-af16-08de80ddb191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VAAEs5WNJ/5erlBtdBknMUOYxqW4Qcv4VEOUBHoS7Byqd2gpydLOIYhD/q9uaWOtwhlwOqGKKmIab7Bi1W1Yz5bZ9mBHTv1a+55gI6SX3ZX6nwkgtkL6uliYZhYrQrrniJS55YAzZy8Dera34jCfuaM+O4yg2F0JilWlxgGg6a4HpsQo4tzo7AwrG+r4VizmLx6Rrsd45k/Tpy+2U9XvKllkpcy8cU/IeEF9yLwf69RR9C2s1dlWrOJ3kjKuXegXS9uiCfUfqbqF4pJ7/AmsqgXJ/YNUG+1nHdaBjPyzg3cwiebw076RGP5cVxxm3zArJSxjyFcGnr6AvKcIP67Jh1VlMoBIzEJmYN2Pr75kPddgP7IYLgBMNlUmw7hIjVp0QGPCIyVw8A2NRyoapUoesO6wY0O2oa9lfnF3PuPkCClg8xuv9rWWR0iH031az8ZqgP+EgtwoqlpgivQDz0CvoLr37kF/xPQL1MtGQTzmo2hrrRNXkJBx4p+fkcTzYhnZ87ssuE9cTOObSLdw/zYL3F7TTPtjbXOeV5LQVGXh5RlAGEb4PoS0RAeq/p5HZnTcChH4dyGQKSWEGul1PYzXDW1H2lCDH5RKey0b3CyoWRmWqWniRJ5Kig1Xfmns4+iavjpFQUxkY4wb/h4XZJPdKoT/nN3VMD93bDr1/DyNYE7EADj9jWW1gNCKzjcTqBEvJyZtGvKB3jUksIsI2DQCkjb19d3Hvnr9WWrJgSTDZ8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JtLjtbrmGgc/nrKpDl28mZAJU6jPUHGWMjDPOcnZHyKHqJ08r/L/dwjy7M0O?=
 =?us-ascii?Q?xZXtDQ+b70qbKqKELPoMaOkcLnl8evSY/36WLoUrqaw7aebtBsbv2wDzmW6x?=
 =?us-ascii?Q?VMHPvgbfDNg5s6SnWifcpOxsEsaZrpBvNl1qbccF0fwgmFcK8G9udf/fxlFz?=
 =?us-ascii?Q?HFzvUcGUa3vjdiRaF2U733i2AYjVtmF6RRlmh4N6pF2ZikUAQLI8hpUU2aLh?=
 =?us-ascii?Q?RVKhOEZLz82Ro6vJSdxhF3a9K3jV5mixfiWvLxJAS7cpXfyajAWLQLvtdwA0?=
 =?us-ascii?Q?UVbuOa+P4UggWlEiwM+JUa+7MfI09IiBKU0s6QYWTlSIq6+kZgwp5aji3fkY?=
 =?us-ascii?Q?anpk4+8hD++pas5CbvSKMtLrD9YI4j7GaQBw01LhfMfrvb2l5wcYKEhS6Wi1?=
 =?us-ascii?Q?lmBIZNhY1ykSHsToQ6ZrKk1m0VqQzh5oCEjEpprIePwJUyRhXWIIUN90og+k?=
 =?us-ascii?Q?PrDVgcniI0g3B/X1tjbSAVDOg5j2Ogdcs1MMYLEMYh3kMcINjGlW9XwEhhrK?=
 =?us-ascii?Q?MalvrGkUqDP/Sacb7j3EqtDiHbi1cwxaRKdzxfiwmJPexILteIw3Ry6wgbX4?=
 =?us-ascii?Q?eDCnBvGIAjKv1TV/CAS56tz8GuT+pR66HoE2GfBBjF8cbvNhJv0+jj0ygMYA?=
 =?us-ascii?Q?uZbiUG/AtykqG/bxsrS6J5NQcOmrdBBv3Zm4ZUrv1eRpgIvaARTZf1jTYX7Z?=
 =?us-ascii?Q?2769WQj/wTX8PrGsiQY2wXbrSauaY5Jn+JGDxupGEZcA03LzeO5e82BGtvj+?=
 =?us-ascii?Q?Rc8N4J3HIBp5FALBCenSvshYdvrNrhmX+MIYxe8tlEnOplTobwaY6vzKmwlL?=
 =?us-ascii?Q?E6BeYmYzHxi794GGpxxrto5KEpBglHV21M3hoVT1eL/Z0kZssllGvOLnEpIa?=
 =?us-ascii?Q?uWz+6NP7Sm7CfaK2c5aZvB6dwWvrnhYL5znxqfVFEcjtAkrxlxYijo9fvmaf?=
 =?us-ascii?Q?3o1ubN1JNlep/30zjERF1xZo4jZa6bzEg4W/3wBuZn6HwL8sU28FaBg539LH?=
 =?us-ascii?Q?UBblX7ToyIdFlyUqiFV58NyG1wg623EKr2YvLh66LxP2f2Onr2AZZPW6X5kn?=
 =?us-ascii?Q?dpzl6qumOSoKvg+LP6gY/BEEoG3FJgJVOtJL+geFINwHfhJShmLIgg8xrJ9f?=
 =?us-ascii?Q?Q4q+XzmtviGOBRZNtu0tE7gWqKSGzlKo+9QaUdK0ynbsHR9/IS687/AAIy8s?=
 =?us-ascii?Q?VNcX+3GFKAuHELYaixcDVn8uvx7FioZvlK9F0vC4JakU54lHjmnXOyxuR3px?=
 =?us-ascii?Q?zpEKMzqTzelK4it0O6EL8u2txnk5rlLrlRhXUfNuHX3dF494qRW3a0ZLy9re?=
 =?us-ascii?Q?L//3ns6/65/uKwlO+GPDOlUleGV7h2qyjXFCn/LLJ6lELtW4aksXkkGlweCe?=
 =?us-ascii?Q?ED1YfGdiFgUY1UqQE2a7IMDy6EFI/2bIzYT4SD3JxAoMd9IVMPMiKYr7BunC?=
 =?us-ascii?Q?h3mlwGHt4cltSd+hmH5rgl6Vkio8+pK+RAt2Q019itiq6NdgivY2frPFIrWi?=
 =?us-ascii?Q?dH8E8+1L7aJN6vd/orXhQeQ9I1HUCM+ThaLtGRYgCovlUcz+ihsoH18nQua0?=
 =?us-ascii?Q?A4a+AaRx+NQdLyqqWoM/gk78OU6nRSYwGh6s4CyArNd4bPcZQ1MoIT6Se/EH?=
 =?us-ascii?Q?AB8v8vYLleqlPb+cc3yAdOdE/kCV+k8hYmfvgMR6GNkRe0P7CjfnWMAyNvpb?=
 =?us-ascii?Q?u/kezYUON2lfufWOnZ8anYSp+e7C8jvRQrMGT/tchpMWWYLTDj1uOtx50NxP?=
 =?us-ascii?Q?p1Nnz34zxHFzwshzXnHO4XOLNook1IYFv8gYpNg0r9uD6/Qopyfx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e37826d4-82c1-45b9-af16-08de80ddb191
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:51:18.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9GxXC6M+jY554quQYlEQzVq8SDv7MnXKF3La3DqLVqrTbH79u/bU941JdkAelm+WsbuUnWudYAvuc69AU9IQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2181
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9425-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim,valinux.co.jp:email]
X-Rspamd-Queue-Id: 07FF427FF4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 04:05:21PM -0400, Frank Li wrote:
> On Fri, Mar 13, 2026 at 01:49:51AM +0900, Koichiro Den wrote:
> > The exported-DMA path needs to describe each exposed descriptor window
> > with the DMAEngine channel ID that owns it. Those IDs are only assigned
> > once the channels have been registered.
> >
> > Cache the dma_chan IDs in dw_edma_chip after registration so controller
> > frontends can later publish them as auxiliary-resource metadata without
> > reaching back into the live channel objects.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 18 +++++++++++++++++-
> >  include/linux/dma/edma.h           |  4 ++++
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index cd34a3ea602d..a13beacce2e7 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -837,6 +837,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  	struct dma_device *dma;
> >  	u32 i, ch_cnt;
> >  	u32 pos;
> > +	int ret;
> >
> >  	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
> >  	dma = &dw->dma;
> > @@ -932,7 +933,22 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  	dma_set_max_seg_size(dma->dev, U32_MAX);
> >
> >  	/* Register DMA device */
> > -	return dma_async_device_register(dma);
> > +	ret = dma_async_device_register(dma);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Cache dma_chan.id in dw_edma_chip */
> > +	for (i = 0; i < ch_cnt; i++) {
> > +		chan = &dw->chan[i];
> > +
> > +		if (i < dw->wr_ch_cnt)
> > +			chip->chan_ids_wr[i] = chan->vc.chan.chan_id;
> > +		else
> > +			chip->chan_ids_rd[i - dw->wr_ch_cnt] =
> > +						chan->vc.chan.chan_id;
> > +	}
> 
> why need cache in dw_edma_chip? you's cache into chan.

The reason I cached dma_chan::chan_id in dw_edma_chip is that
dw_pcie_ep_get_aux_resources() later needs to populate
PCI_EPC_AUX_DMA_CHAN_DESC with a key that can be matched against the struct
dma_chan instances returned by repeated dma_request_channel().

The delegated set returned by repeated dma_request_channel() is not
guaranteed to correspond to the first N READ channels, since some READ
channels may already be in use by another local consumer. So I do need some
explicit matching key.

If you have a cleaner way to correlate a delegated struct dma_chan with the
corresponding pci_epc_aux_resource, I would be happy to rework it.

(More fundamentally, for sparse channels export I think we will eventually
need to carry the hardware channel number separately as well.)

Thanks,
Koichiro

> 
> Frank
> > +
> > +	return 0;
> >  }
> >
> >  static inline void dw_edma_dec_irq_alloc(int *nr_irqs, u32 *alloc, u16 cnt)
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 9da53c75e49b..0b861e8d305e 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -100,6 +100,10 @@ struct dw_edma_chip {
> >  	int			db_irq;
> >  	resource_size_t		db_offset;
> >
> > +	/* dma_chan ids */
> > +	int			chan_ids_wr[EDMA_MAX_WR_CH];
> > +	int			chan_ids_rd[EDMA_MAX_RD_CH];
> > +
> >  	enum dw_edma_map_format	mf;
> >
> >  	struct dw_edma		*dw;
> > --
> > 2.51.0
> >

