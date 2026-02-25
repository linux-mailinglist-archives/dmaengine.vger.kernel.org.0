Return-Path: <dmaengine+bounces-9083-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOQrAo4fn2l3ZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9083-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:13:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF419A538
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9EDB31F7597
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9DC3D5258;
	Wed, 25 Feb 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kpHYkpvG"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF43AEF4A;
	Wed, 25 Feb 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034654; cv=fail; b=sH6Pj8MznpliplKRII6rJjl8tvm97l7MtVgP0bkRS9d2tlBSVfzPjx2DSz66ecUd5+405dhmhFB9XonjqLBm5ZM+LkYSJ+jERKuTOmxAWlLx66LDe+pWkFu4xVfI3Bd4ZndMk/ja6QlQ1FF2zsfVWQna8ZAWroLivyMQcHqSQuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034654; c=relaxed/simple;
	bh=SS6rS5Tzx+KGpHlZSo9Osl8JNTpfSohnzH+tZAyfKn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D48nKYlOvzoAZGIFE+0+dKdOqsApyhHrpqz/PmH91OttGtO9UB/peobOo9ZGNxQck0O5MQ3bKpVisfa480g9LBWM450bLxJpeHec1JKunPpwk1om6aqN2DKPQ24AUbJjBVJxz5qr+G7jEw5Q/vM+W5ie3wpeGke1Q3JDnkOnj38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kpHYkpvG; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbZVopnMYulDhCw23BNwXTyJmfjvx93dd7FbrTkDOXVEbRSxwN4Ra1Ya8ABZniHyNBK7FrpFD1A/3WN31SBjiF8NR8nWKmsQPvdBfGtMT1eb4nLWyRJ7iQEhoOHDStlnl+yZHMmXqjiaQLbvxXo+/KhnczAHVmb/y5yMuCU36g4N2GXW/ea5ie/0rt5mQXHComGxj4IYs2JpNvrw5xUtCHcz9VOdHzLHaJ+zXZGFxy8TJetF8MJSPBPxXfCmC3YCTNx3duscsJSUGPH+CP9FYv7QQXKJB8j5irDsDO/80axxk9fcdhkffnKjma14vu43NjXTh+2BCyVQdW890SnFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5WeJceSRnwNjdh835HAjuGI7eITjb/uUESY9vybVmI=;
 b=JEeOnUD40/Qe36kBhdN5rXkSJ+hko63atf1CZH7o8oZNRWHG2R1El6pr8p66ZZb+rGAVO42uy1ENEzuR7HGLnt7ERqqbwgd8ukaSv8yJGHrbftLjEopeFtTuLkf7EYAdtl6K863QyQytiIfH9V+NT8lTvSMt+ulSp2kOi4AZ28TGY9jrs8YCYO0nSn75wQTYhCHedzVr3eMDL6C4NgQk0Bz5zxdRblEtQya0OH+xNlY2LMsXp7XQ1wGx/xLsUrT9FWdOzzx+1vJXqQMYTsWBG/6umK04FoJq2Z1UwNi8Cab9Ut4cTgsVy7FEteB6GnZjTRlJLm02w5k8ZyEz89VWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5WeJceSRnwNjdh835HAjuGI7eITjb/uUESY9vybVmI=;
 b=kpHYkpvGHvsHa09oNFOIR3yHrtECqRvfCMA8irCrPLTAhRACTRcvc2YWwZ5eueWrPD1ujebt19sXhkL32d1X05udG8cvs/76lRPtWaxXZk88X/rM0cfhpZbUEnlKpJuh4PmZPP/CC14QuIrCksvTztVx5QaBYKFCgSCwx4P+lJ/DoFGxCCgYfiaK5KH/D3s4RnIBYZ9E3tMFkCHplanNNWEIuBA8DjwWclOI8LVn/S5Mdmj6spP2gViKaI0ULmm9RgGoQ4bBBVNVVKgKqMnw6klQtCMn3+COE35IQho5M5i9EpDji76897SVWOIxUtipp4dILVXUDoaJA5EIfMc1nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA2PR04MB10424.eurprd04.prod.outlook.com (2603:10a6:102:419::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 15:50:49 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:50:49 +0000
Date: Wed, 25 Feb 2026 10:50:41 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 01/11] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Message-ID: <aZ8aUcV4RN2EL5n3@lizhi-Precision-Tower-5810>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com>
 <d7mh5d2amod6uzmzib4qnun46al73r77uljzhizq2v6w5ame4v@et65inoxhexa>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7mh5d2amod6uzmzib4qnun46al73r77uljzhizq2v6w5ame4v@et65inoxhexa>
X-ClientProxiedBy: PH1PEPF00013311.namprd07.prod.outlook.com
 (2603:10b6:518:1::c) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA2PR04MB10424:EE_
X-MS-Office365-Filtering-Correlation-Id: 38309916-0cef-4f9d-903e-08de7485a569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	hPqqWb6fongKR/Cpj3AwqKrVJZMoE7D1zSagTnt5rhV1GNvR0TFD7mtJ2ggeRu81zmAq/FEWmDI8FdbMBRSB5t4bb6RGNDc082QuWWb1tpZ4cFeEnkneswgYjp5d24I3AC6kHjNKOt8Vs0si6qTWcJy8c4SicX3kcbaBsbYo6fetEwb8TFrBEGU/ScKVSQq8pU8ODD1t822olUBnYYBZH0Hw01dKiZwC+F+s5Z1yf9PZsc6zLILZH3pdx8evZYwyxfYeWUVyEQpkTAMUXYxLlNjGtoh4nk9BmnvQwttpLPGqw+sWAOskZHtZJ6MfsGoQro6+H5VGL0kKunHL7sOkkIntpojR8jBE3sdvJizPCaX7UZCeYjeA070Sawgxaf5uqcIDqBoNIdOSV64eMwAc7lrelJhAeHGCXG+Z1Letzh4KBmzO4lTHTflzimsBeuryapzw89pvMkmWr+/DHQJCSFn754h+PmAGs9Pzrqq3QNHXN/NWOlEg14fMviK0xppV6EGl5dJ6K1BsImTMSK9mnkY/3Waz2mNbqSKa5sXvr2nHSaW1tmBbwmYZOqBKN7Q2oJEna+hgGKVlv3YIG2hZw5aWEC+45x5F8rP9mfwjJOdHw37Ma7Ls7vU2bs4ch/6IBLqHk84GyA8wrhqf4jRMB+ZmfHk0F7DthAfht+sCQPo1s69XlwZzRY9GHg73nfesPX2xZwj18+CyZDWEonJqsoFakM0VCUnGUqmk3I2Uy/Hp2kjqirFRkVHRyi4W9xs7hoS8S2PMTDc3y7eHgtCfUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j3IZSzSk8jZPNqRCizTjN1F8Ite6y3wzPEB7KvlUH7m3O4sJEI02JFODH4QE?=
 =?us-ascii?Q?cGkQ7RlqL8x0VNHQQDyUfwQGXchpIArHpCysz/CryqilZibvuww3+LplDGCy?=
 =?us-ascii?Q?xnV/YUk2REm1+t1CZY8cJijEFVv7uwq2m7AOfhzV+BI6BQxsXCMZH04Ekpm1?=
 =?us-ascii?Q?ckMS3lkYlt92JOQxJi15aC/jfUG55UU5pibq+g19WErQ68jKPE0ALxoLysmQ?=
 =?us-ascii?Q?ijWEyvSmbMAbn+DZF0t68mejD8QjBFy2o6htT3hj494NzRafQbqZDsmKMygb?=
 =?us-ascii?Q?oDAod/Fy8MB4Tb1EEkVWRawQ5os6fJ+L2rUz8HS6ASi7bUZKtSuSQq4JBPfc?=
 =?us-ascii?Q?8tIKVwsKqAsaZlJtvaQEHRwnAKuQ9QupVLgeVYKorZd1JOKQL83jwLwM9Gx3?=
 =?us-ascii?Q?mVxH/bwX7w5BfFCze2nxRYw8pVkcNpJeT1OcvayYg6vY3pp0ncipOutvrSM+?=
 =?us-ascii?Q?bwP1xskbssOWWvD0Xf5V4mcCUa9sW3N7x54PzAwmJZDDbFXqS2MfE3xsNpJH?=
 =?us-ascii?Q?dPA0SolBohmXIezTqZNwkp/XH0Ejj5jfHmD7qUwx8LUFbuo1Xb5uy4RwajgM?=
 =?us-ascii?Q?4SITV1d9kfyW9ucyma9Kg0+ijnujwR/J1hg7VYOT9H+rp9sozAM8QJ4vA0W3?=
 =?us-ascii?Q?VmIl4x9j09xd92o2iPfoWHdPTAG0gG6CSbDWbKnBBGG01QlRGPD1xbBRmylU?=
 =?us-ascii?Q?pboN2wmya7tMjmD0wZfmVCLWuOI/+sVCTKC6t7VF3TzNf8Tb2uRJ8VjnWJc9?=
 =?us-ascii?Q?ujIW5jHM6uEXzFddNtJ6ep6OMPcuj5tZG4gKCTlu54y5/pINJbnupAMomwNM?=
 =?us-ascii?Q?M8BXJELgBRjHNbq02WHKWVs/qT5PQvTOUQxY2HEqlNZAiWWoHzcrzWIIYsBt?=
 =?us-ascii?Q?fm1rztP2WdsYRxj6mRdday8+0anOm3RT6NI8hCLlmYC5bgA0eTcHSrPVOIGy?=
 =?us-ascii?Q?mnMs6UHZcWn8g5jfKBcpejUP0zYO6qY+KbghF1rk9/nigUVhDV/x2rxftpTA?=
 =?us-ascii?Q?A5FsCSyErxE89vFzQrZs8Vnmikjej7O6GUhAQqNluECSnvuyRM6GTRcjEWLr?=
 =?us-ascii?Q?JQqT9lm+zMlP/W4/CnIJKLI2Dy2vBrV2yl9p/xkBGmwtii998UAn99mnJPAH?=
 =?us-ascii?Q?zIOPQw/+T1AL+H6AKkNWQAXiHnmIQF6em7aBQQlmYWmMJIRwyB2l8Y9jyqxu?=
 =?us-ascii?Q?aiRY7tTmUaghUuGpwRPMZGjHrsidvkA7NE3X7IGhBKkKyieIOymuae504gRS?=
 =?us-ascii?Q?P6r5MfXkOeVHnxp9MCN5sApFvleKUTbS0KqCdby34oAbNg9kYYNn7noy+fH8?=
 =?us-ascii?Q?+6Wss3LwnGYEF5tZ+LeoER7q1lZdpHWXm3B5SR9m8N+oQ9hW0qWjI5d4fPDR?=
 =?us-ascii?Q?lZwo37v9SYY9B4eyDb0dpGcBjE7tM5r/wiHcC6GMvfna1jLLDiB+qywDTpjY?=
 =?us-ascii?Q?txfbd7SMGYS6LrhfvD8E5vSSpepnyRjSlsiJkHq3HGbBFyeKOONbTflpqxLZ?=
 =?us-ascii?Q?mBz3v8ElPVE8HMFjVIdHDyJMtWEqBPALF6yygdg9UFFqxeecm+Bx50/4RbSR?=
 =?us-ascii?Q?XQgUQO2bAb5ebtayJpjCQvU3cYTZYynxgNaW01LtXp5v6WukoWBsi7y8sk4n?=
 =?us-ascii?Q?Sh2tFx7DjHaT0M4sofIfeJqEbBIxY26x/Kbc9JEHxuacTZzd/BaYIzWq5tPC?=
 =?us-ascii?Q?qq/1HjY79SF64JqjTLIfuvcw0Kim9EO2OfiB0uxiU8xwnR7F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38309916-0cef-4f9d-903e-08de7485a569
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:50:49.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sj4JaEzPpo17A3v4TXOm43PhIpuY92cd9E5MO3ggSKWWIcj6ZtOBIeBTbhlw8VcTdZEz6eXrVjXNC7ErM7cdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10424
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9083-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 8FEF419A538
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:26:02PM +0900, Koichiro Den wrote:
> On Fri, Jan 09, 2026 at 10:28:21AM -0500, Frank Li wrote:
> > The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
> > channels, and modifying them requires a read-modify-write sequence.
> > Because this operation is not atomic, concurrent calls to
> > dw_edma_v0_core_start() can introduce race conditions if two channels
> > update these registers simultaneously.
> >
> > Add a spinlock to serialize access to these registers and prevent race
> > conditions.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > vc.lock protect should be another problem. This one just fix register
> > access for difference DMA channel.
> >
> > Other improve defer to dynamtic append descriptor works later.
> > ---
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> Hi Frank,
>
> I'm very interested in seeing the work toward the "dynamic append" series land,
> but in my opinion this one can be submitted independently.

This patch serial is actually straight forwards. we can ask vnod pick first
one in case have other problems. put together to reduce patch's dependency.

Frank
>
> Even in the current mainline, under concurrent multi-channel load, this race can
> already be triggered.
>
> Also, with this patch, dw->lock is no longer "Only for legacy", so we should
> probably update the comment in dw-edma-core.h.
>
> Best regards,
> Koichiro
>
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index b75fdaffad9a4ea6cd8d15e8f43bea550848b46c..2850a9df80f54d00789144415ed2dfe31dea3965 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  {
> >  	struct dw_edma_chan *chan = chunk->chan;
> >  	struct dw_edma *dw = chan->dw;
> > +	unsigned long flags;
> >  	u32 tmp;
> >
> >  	dw_edma_v0_core_write_chunk(chunk);
> > @@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  			}
> >  		}
> >  		/* Interrupt unmask - done, abort */
> > +		raw_spin_lock_irqsave(&dw->lock, flags);
> > +
> >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> >  		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> >  		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > @@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> >  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
> >  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> > +
> > +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> > +
> >  		/* Channel control */
> >  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> >  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> >
> > --
> > 2.34.1
> >

