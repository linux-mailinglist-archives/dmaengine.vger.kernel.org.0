Return-Path: <dmaengine+bounces-7449-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20BC9A3C0
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A6E3A48D6
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C42FFFB3;
	Tue,  2 Dec 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IxTVSn7+"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010048.outbound.protection.outlook.com [52.101.229.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162F25D527;
	Tue,  2 Dec 2025 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656600; cv=fail; b=YwDFFHrNR3FvomNfXquvoKC//7uc2EfBxKjNC9Z2p2/Ja6Qc3vlxvLMIBK9df376C4T8o6dWtnzFFHYX/fcn28Z52khZfeXAVTn4xYKClTBVou54KyUXf4rfv49nO0+KGVMiYWCOrftPRNGsIriZ3HN1R3fPNGBCfvTUNLZmXzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656600; c=relaxed/simple;
	bh=Hu1sBA9StH/bKzcIDkNfttaUxGSD1bfnz77c8XaPVdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YR+R2nr5r9i8Ybgci7kbLkedyx1G10mH/E2fL+DT0+SPGeNgM5OJueuvdM9DDSie3/JoWWsNlyePVrtwXJcfAvokV8r1DYLLRN/5CIxh0+KY9nF/GyxoKW99ahtvi1ly3ghFdG5uXB6OCx0SYLwLGFRNrr+x10woic5WONtKqOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IxTVSn7+; arc=fail smtp.client-ip=52.101.229.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+9pTRN1A3M3qRmbixEodmxD3WBaGnPkRU3PDA9Z8N49BLAOf5ouA47abvTS0m1TLDSphXOHx41vzFMrBxrzV9Pm4Fna/8nq9wC22yc7kD4LdrWsLPa3sVSjbByNUEaOkj6Awsl11EZzuUAEX0R/+u/Ps4Pa518jJ89MuapgkVbmKmaMwA8NrgBMBBgnFpW5H4FYWIsvvuNOr2uL03cDqVyhLrCfE9OHUlMVK6IMbdG2BuIzQunne8tcujiQXnaH50ArMUTvek0dS/BfPiTmsLh/oIPaESKhaFe6/l6Vjf0a0he/u7BbUbyqIGuh3VlLvsj8sbhte8yFgsUVES8ypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QTWCEjGcsgsR01Fh1/g9BopsRUNg1htRG/wVOcVh/g=;
 b=lEskD/XkGK9l7TewxplJYl9ICN34jR9DVVPC1B03qa/Bcv5RW705OWGlp1S4IeeobNlyyAP16URweM+ISkeAG3pvs/8yVU6JU9cQ+K0tf8ChjsoH132iW9lLRHomfdRM5iL8ijhcAmqMJAySCzQ7mexfEGlgnd4skQ4OqLxPVvyU2GTMGKLSXVOcH3lBzceF8vz+wIDtfjXsnFAxzFwqetD9+U9ql9RPh9/zgpyi1zD/xhzbb0DDXFpTa1GzRMTbbuCCqhwuyfPPvVC4EII85ry8NkGfxdGUvTVVZ7i3nqfwpsG2t9aacpQEBDladjQq/Q9sqz4L54ZDt6AKVSkWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QTWCEjGcsgsR01Fh1/g9BopsRUNg1htRG/wVOcVh/g=;
 b=IxTVSn7+thbCI/ZnxCS03DOA5C5i1l7BBNy7swthZ1fibWTwAf3NlhhaC5qVZwHT5qQdxLpdKE8cjkZXkQnsmz5a5hKLzHseZRUPFjyn3mgumq5cKk0NgRChcO1aQ5QA0lsl+Qz/6H/9nIjzxMLb8CEesq2u/X/FAv7F7Ej8UO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYTP286MB4024.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:185::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:23:16 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:23:16 +0000
Date: Tue, 2 Dec 2025 15:23:15 +0900
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
Subject: Re: [RFC PATCH v2 02/27] PCI: endpoint: pci-epf-vntb: Add mwN_offset
 configfs attributes
Message-ID: <o47cam4tmc6274mw6oucwks3cycdjcfycwb2r6pgkndhlk3wmm@oau6km62lugo>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-3-den@valinux.co.jp>
 <aS3oS8kg7e2aI98R@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3oS8kg7e2aI98R@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0056.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYTP286MB4024:EE_
X-MS-Office365-Filtering-Correlation-Id: 24968995-582c-4c17-06ca-08de316b473b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BLtSAHjW9o7R+P8pube7UHROiVV3Zy4SLoSEinSR+WtO5atvnqDXX00Wuu8Q?=
 =?us-ascii?Q?ZcTKtLWAyCsA5qqn56YSKFvUM25XDg5IFxlYZrybAf2q/2oPHJs4KfsZBjds?=
 =?us-ascii?Q?B3ACNNtGv/tPMNS1C4A4pTxGIWh5YCp1TkzHgz3SZGWAuC7WaOCNjhihsEgr?=
 =?us-ascii?Q?i3Xz8amQsrCiH77/F+ogztKTyX7enX1+CX4KmTX3aZ3PVEm9WRDl1dsLOhWn?=
 =?us-ascii?Q?NSKNHtOnjlb1giB0y7bbXh8zn3J64nkr08zrfOyvc2wdrPdALwA0XnH4d5WY?=
 =?us-ascii?Q?Hil9pG77KAujc5j96h975X6HEIsqyw0QWM2A0X1DHKPkUEWg6RPfM26cG2WD?=
 =?us-ascii?Q?EihvthgqIiY7L2I61zci1+iYPU/BNmogj7jfbHAGmqOvcDDtfQ930IkGgLTW?=
 =?us-ascii?Q?oNjvQYN4WShLy3zmxmILCn8lXBO91zN/of1YuSXPgkQSi05R5tqBrlAIPnLJ?=
 =?us-ascii?Q?Z1Mo3zLZoAQC97EssymezMmGjy9k1lHnCakBkWAiHqLKwPwEVc6FPKTNIAv9?=
 =?us-ascii?Q?QZLQO9a9AUrI/uYr68zKF5oab/vGJPKuWMatji6JY0ND94dxyBFQIaFPIeH2?=
 =?us-ascii?Q?d8kCQzeMSuc5UdzNS+xxUkb6NfhykvxC1qbhkfmeXn6o2oGJtfuNwifeNXm7?=
 =?us-ascii?Q?H7MNiuebrN3COw1sZILSwXx8ij+K5PQxrzw1RNQD9ai0uELkuOPXMKyx4xxM?=
 =?us-ascii?Q?lU4lfAoAqFuOk5x/oKVXiPdkvA3W1Z/kgJ3pGaUgUWHjF/fUtspBiSxcAClw?=
 =?us-ascii?Q?iFzrBXO2+eWFnrWGll/vAIG6jfmjOGeIojGjfQxIbxzZSFnExHtVpJXYprGp?=
 =?us-ascii?Q?xL7Dte2bRJLWoI/MinmaBAozXOnGVEjo/4BNTp4f0tucg1hOxTh3mC3CFG7l?=
 =?us-ascii?Q?p3w50oKB+lcA5shvAZiPDJSjLzzoACPNYFf3aQv6wW5t0oAXRhw5lhOri8/3?=
 =?us-ascii?Q?9rAeZmw89DYLnfICt3VmHrG9Dnc7/vIm6hy3DtVb2EQj8hSN3Xo6ODi+G/0V?=
 =?us-ascii?Q?/QmU1wcXC3bkEMxD/B+KwR5OQsvg5bRaFDLXJwq0hAdAJzK1acd+jWWAyuWN?=
 =?us-ascii?Q?FY949PEUEgkFD+85/z6DbZtYjfcElHdfmkxPntifL8eYw8c3PDcoUQrj84ZV?=
 =?us-ascii?Q?vT0wDBf3XH/RJRqdalovN56Iq0cmfywdda/YU5a8QgDqlxmUqOZnFv0rLrYe?=
 =?us-ascii?Q?6wueQSszlqqtKod90b0uvYX7m3XUydkWM8ucQSE2ZxSU4ts6uhJU8OCGNeyF?=
 =?us-ascii?Q?5//J9PH37NcrCFdb9K5Uc47ZpEpX3uIhp2IHMqV3zOhQJTExvmXXDXIowVYU?=
 =?us-ascii?Q?35WP3xpfmW3iUdwio3T0zdB3eeI0MGw32ORIMJ3EtRmZMmGpuyxjzfzjakST?=
 =?us-ascii?Q?jFfQJgDLvI3PnBJu8SyrLQw8aySSahKHwFzTYKQYljfJH5Pp2RWWJVKXMKhY?=
 =?us-ascii?Q?vdTDJvll8ECL0sQsn2tshwy81YGhuo/ZEVkZjdtPOucS15qG+Q9o0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iuIeE7M09I50+6jonQDbm8LfMaMTa8fSHTX+Lxlu3BDHO+DO0ttLHaZpSWVe?=
 =?us-ascii?Q?D0RqNemnYCLSQGF1JPZxclP8Ip1tCG/TjVsJU0lvry3iBZMhATXxcMs7ewj4?=
 =?us-ascii?Q?p4YlpfgIzeciwH2EWBMxJ3tPmxQpyBFXyekNVmOFyLUiZ3ejv8fx5p7mTEGO?=
 =?us-ascii?Q?TzISfaakY0NFg0Njd2+G/JZ6oExoOrstRyN7NkK19t/RXgM1YvHRpG7MhnMd?=
 =?us-ascii?Q?mXua+n55F+G6r6odeIWRhJNrY4WylzSWsI6Ap1QDjhVZsFKdJhHjLKDKCMZa?=
 =?us-ascii?Q?gYH2CXwb9hxPsn4CQblolQQ/nt6Z/wtZQX9j7FQudbFKi7R5+2tzJbinaqU8?=
 =?us-ascii?Q?5OV5o0egDcrEM8VIMFKPB4u/IH6zeYiQucK/JoPYo4XQIRMrORFXBFoHTnQB?=
 =?us-ascii?Q?vkaeL9ODGJRDCGVCMowWuJcoNlpGhB9Y44ab8zF3YTSem980pmJOb3PFVcmm?=
 =?us-ascii?Q?R9r9mIIjU3s9xiVxxh5FjEc8R3EwZ22YlJq0QKi1Gbx7t3kw0/Y1gow7HCAU?=
 =?us-ascii?Q?sQT6ElTFsc4csZx7NsNwvxJRxT5gl6/cyLQkdBVEMWxdYK7C1Xcqo/3w+wD5?=
 =?us-ascii?Q?SY8MqH485f8yGkFgwHKjfbkJNRsD+0kMjWaepizO1YuseSsm0TbQ6h7pwApy?=
 =?us-ascii?Q?CO0FnZIA195FzoNoGs9Z9NCt2rc8SisJ16RnRViqnyLYiIg2jlJp1MP3Spc/?=
 =?us-ascii?Q?8+E+Fnx4TbtGf+hS8OsveGiqmp4aqB4PgGvNWqP0hQqYf3mXoZ+K6zzHd1W8?=
 =?us-ascii?Q?Pjl7MZAAfD+X769caTYEqst3n/J4TXIynXMzlCWoxEd3jgCjqoII2ckh7F27?=
 =?us-ascii?Q?ziAY1c4q3hK3inQCJXnv7ltNu2n3AsIJumMypkItp/WD5V+pufrhrUYqEXGM?=
 =?us-ascii?Q?A5wwOt70Ws0EAuJtJp58yjPlfLGQqK+AY0tXX7P62ZwI/2ZD1r/IyxWVi6TQ?=
 =?us-ascii?Q?mDPznkHiTga6AJVuT8+W3jakAmS8y0J12GumACVd0VwLkZXknFrq/wTC+gce?=
 =?us-ascii?Q?12rbdazTzROF+vK+bLa/p6XteYSj0ywlMFsG5aZQUJJQhs7S5fnMJRXmN66K?=
 =?us-ascii?Q?pAkvYdrqqq66U4Pfpx6bjAH/Rq4J20ah1uGI2+fcwRA0GEMtWuud4alCjnwP?=
 =?us-ascii?Q?EVK8Ya6nR3tUA/2hFnYG8urjJl7MHZ0u2ziufwAvfNDmK3t2xzYyzTUABgld?=
 =?us-ascii?Q?6Cu1arf7tyeuCIpTaVToogfVKMH/EEATZJYXHMu4SQbEYIX5A/IX0RUJWxkv?=
 =?us-ascii?Q?e8hxlQqRkKqW8NdTxNcON/lKl4LVxUn3mBJ0SAVz/ajSCIzDTZDtbS3ROiTU?=
 =?us-ascii?Q?HspIr57I4TB+oUpSDX8O2Gc22UoS84lTIIrTElfu2qyYYs94dFDdbldlyR54?=
 =?us-ascii?Q?/bj0Fb+n2GgJpbK9avQZQrqC9aTagHXJNol8hJDmKObxmPiJ0p3o85otFikj?=
 =?us-ascii?Q?k87u5XMPQN633BLOq1BZAZH/Dbk8jRun1N/GG5vWDRv0L0SJ6wIw7OaVNBWu?=
 =?us-ascii?Q?+q+xX2TODt36XshgueMl5GoSeTmF7OtXA2a6xIsL+7qNxol7eaH6s46OuPuF?=
 =?us-ascii?Q?quDRil9jMxmBPwpo63nwOWy7woPqtkpjcSqB+jVZ1edqmEyI0C5CBI5bFIcG?=
 =?us-ascii?Q?hsZDJrAhv/UzI11aIBDA74k=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 24968995-582c-4c17-06ca-08de316b473b
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:23:16.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8dlkgJWSfPvTR4xYNvL+wqSPzrKaemZmRrS1KA+5nHvKg7eEPwhKdbHZHwLdSsBZmEN2aMR951Ireoc+70Csw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB4024

On Mon, Dec 01, 2025 at 02:11:07PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:40AM +0900, Koichiro Den wrote:
> > Introduce new mwN_offset configfs attributes to specify memory window
> > offsets. This enables mapping multiple windows into a single BAR at
> 
> This need update documents. But I am not clear how multiple windows map
> into a single BAR, could you please give me an example, how to config
> more than 2 memory space to one bar by echo to sys file commands.

For some reason, I mistakenly dropped the doc update that I had added in RFC v1:
https://lore.kernel.org/all/20251023071916.901355-26-den@valinux.co.jp/
I'll restore it in the next iteration.

Thanks for the review.
-Koichiro

> 
> Frank
> 
> > arbitrary offsets, improving layout flexibility.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 133 ++++++++++++++++--
> >  1 file changed, 120 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 6c4c78915970..1ff414703566 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/atomic.h>
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> > +#include <linux/log2.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >
> > @@ -111,7 +112,8 @@ struct epf_ntb_ctrl {
> >  	u64 addr;
> >  	u64 size;
> >  	u32 num_mws;
> > -	u32 reserved;
> > +	u32 mw_offset[MAX_MW];
> > +	u32 mw_size[MAX_MW];
> >  	u32 spad_offset;
> >  	u32 spad_count;
> >  	u32 db_entry_size;
> > @@ -128,6 +130,7 @@ struct epf_ntb {
> >  	u32 db_count;
> >  	u32 spad_count;
> >  	u64 mws_size[MAX_MW];
> > +	u64 mws_offset[MAX_MW];
> >  	atomic64_t db;
> >  	u32 vbus_number;
> >  	u16 vntb_pid;
> > @@ -458,6 +461,8 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
> >
> >  	ctrl->spad_count = spad_count;
> >  	ctrl->num_mws = ntb->num_mws;
> > +	memset(ctrl->mw_offset, 0, sizeof(ctrl->mw_offset));
> > +	memset(ctrl->mw_size, 0, sizeof(ctrl->mw_size));
> >  	ntb->spad_size = spad_size;
> >
> >  	ctrl->db_entry_size = sizeof(u32);
> > @@ -689,15 +694,31 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
> >   */
> >  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  {
> > +	struct device *dev = &ntb->epf->dev;
> > +	u64 bar_ends[BAR_5 + 1] = { 0 };
> > +	unsigned long bars_used = 0;
> > +	enum pci_barno barno;
> > +	u64 off, size, end;
> >  	int ret = 0;
> >  	int i;
> > -	u64 size;
> > -	enum pci_barno barno;
> > -	struct device *dev = &ntb->epf->dev;
> >
> >  	for (i = 0; i < ntb->num_mws; i++) {
> > -		size = ntb->mws_size[i];
> >  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> > +		off = ntb->mws_offset[i];
> > +		size = ntb->mws_size[i];
> > +		end = off + size;
> > +		if (end > bar_ends[barno])
> > +			bar_ends[barno] = end;
> > +		bars_used |= BIT(barno);
> > +	}
> > +
> > +	for (barno = BAR_0; barno <= BAR_5; barno++) {
> > +		if (!(bars_used & BIT(barno)))
> > +			continue;
> > +		if (bar_ends[barno] < SZ_4K)
> > +			size = SZ_4K;
> > +		else
> > +			size = roundup_pow_of_two(bar_ends[barno]);
> >
> >  		ntb->epf->bar[barno].barno = barno;
> >  		ntb->epf->bar[barno].size = size;
> > @@ -713,8 +734,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  				      &ntb->epf->bar[barno]);
> >  		if (ret) {
> >  			dev_err(dev, "MW set failed\n");
> > -			goto err_alloc_mem;
> > +			goto err_set_bar;
> >  		}
> > +	}
> > +
> > +	for (i = 0; i < ntb->num_mws; i++) {
> > +		size = ntb->mws_size[i];
> >
> >  		/* Allocate EPC outbound memory windows to vpci vntb device */
> >  		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
> > @@ -723,19 +748,31 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  		if (!ntb->vpci_mw_addr[i]) {
> >  			ret = -ENOMEM;
> >  			dev_err(dev, "Failed to allocate source address\n");
> > -			goto err_set_bar;
> > +			goto err_alloc_mem;
> >  		}
> >  	}
> >
> > +	for (i = 0; i < ntb->num_mws; i++) {
> > +		ntb->reg->mw_offset[i] = (u32)ntb->mws_offset[i];
> > +		ntb->reg->mw_size[i] = (u32)ntb->mws_size[i];
> > +	}
> > +
> >  	return ret;
> >
> > -err_set_bar:
> > -	pci_epc_clear_bar(ntb->epf->epc,
> > -			  ntb->epf->func_no,
> > -			  ntb->epf->vfunc_no,
> > -			  &ntb->epf->bar[barno]);
> >  err_alloc_mem:
> > -	epf_ntb_mw_bar_clear(ntb, i);
> > +	while (--i >= 0)
> > +		pci_epc_mem_free_addr(ntb->epf->epc,
> > +				      ntb->vpci_mw_phy[i],
> > +				      ntb->vpci_mw_addr[i],
> > +				      ntb->mws_size[i]);
> > +err_set_bar:
> > +	while (--barno >= BAR_0)
> > +		if (bars_used & BIT(barno))
> > +			pci_epc_clear_bar(ntb->epf->epc,
> > +					  ntb->epf->func_no,
> > +					  ntb->epf->vfunc_no,
> > +					  &ntb->epf->bar[barno]);
> > +
> >  	return ret;
> >  }
> >
> > @@ -1039,6 +1076,60 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> >  	return len;							\
> >  }
> >
> > +#define EPF_NTB_MW_OFF_R(_name)						\
> > +static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
> > +				      char *page)			\
> > +{									\
> > +	struct config_group *group = to_config_group(item);		\
> > +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> > +	struct device *dev = &ntb->epf->dev;				\
> > +	int win_no, idx;						\
> > +									\
> > +	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
> > +		return -EINVAL;						\
> > +									\
> > +	idx = win_no - 1;						\
> > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > +			win_no, ntb->num_mws);				\
> > +		return -EINVAL;						\
> > +	}								\
> > +									\
> > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > +	return sprintf(page, "%lld\n", ntb->mws_offset[idx]);		\
> > +}
> > +
> > +#define EPF_NTB_MW_OFF_W(_name)						\
> > +static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> > +				       const char *page, size_t len)	\
> > +{									\
> > +	struct config_group *group = to_config_group(item);		\
> > +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> > +	struct device *dev = &ntb->epf->dev;				\
> > +	int win_no, idx;						\
> > +	u64 val;							\
> > +	int ret;							\
> > +									\
> > +	ret = kstrtou64(page, 0, &val);					\
> > +	if (ret)							\
> > +		return ret;						\
> > +									\
> > +	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
> > +		return -EINVAL;						\
> > +									\
> > +	idx = win_no - 1;						\
> > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > +			win_no, ntb->num_mws);				\
> > +		return -EINVAL;						\
> > +	}								\
> > +									\
> > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > +	ntb->mws_offset[idx] = val;					\
> > +									\
> > +	return len;							\
> > +}
> > +
> >  #define EPF_NTB_BAR_R(_name, _id)					\
> >  	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
> >  					      char *page)		\
> > @@ -1109,6 +1200,14 @@ EPF_NTB_MW_R(mw3)
> >  EPF_NTB_MW_W(mw3)
> >  EPF_NTB_MW_R(mw4)
> >  EPF_NTB_MW_W(mw4)
> > +EPF_NTB_MW_OFF_R(mw1_offset)
> > +EPF_NTB_MW_OFF_W(mw1_offset)
> > +EPF_NTB_MW_OFF_R(mw2_offset)
> > +EPF_NTB_MW_OFF_W(mw2_offset)
> > +EPF_NTB_MW_OFF_R(mw3_offset)
> > +EPF_NTB_MW_OFF_W(mw3_offset)
> > +EPF_NTB_MW_OFF_R(mw4_offset)
> > +EPF_NTB_MW_OFF_W(mw4_offset)
> >  EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
> >  EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
> >  EPF_NTB_BAR_R(db_bar, BAR_DB)
> > @@ -1129,6 +1228,10 @@ CONFIGFS_ATTR(epf_ntb_, mw1);
> >  CONFIGFS_ATTR(epf_ntb_, mw2);
> >  CONFIGFS_ATTR(epf_ntb_, mw3);
> >  CONFIGFS_ATTR(epf_ntb_, mw4);
> > +CONFIGFS_ATTR(epf_ntb_, mw1_offset);
> > +CONFIGFS_ATTR(epf_ntb_, mw2_offset);
> > +CONFIGFS_ATTR(epf_ntb_, mw3_offset);
> > +CONFIGFS_ATTR(epf_ntb_, mw4_offset);
> >  CONFIGFS_ATTR(epf_ntb_, vbus_number);
> >  CONFIGFS_ATTR(epf_ntb_, vntb_pid);
> >  CONFIGFS_ATTR(epf_ntb_, vntb_vid);
> > @@ -1147,6 +1250,10 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
> >  	&epf_ntb_attr_mw2,
> >  	&epf_ntb_attr_mw3,
> >  	&epf_ntb_attr_mw4,
> > +	&epf_ntb_attr_mw1_offset,
> > +	&epf_ntb_attr_mw2_offset,
> > +	&epf_ntb_attr_mw3_offset,
> > +	&epf_ntb_attr_mw4_offset,
> >  	&epf_ntb_attr_vbus_number,
> >  	&epf_ntb_attr_vntb_pid,
> >  	&epf_ntb_attr_vntb_vid,
> > --
> > 2.48.1
> >

