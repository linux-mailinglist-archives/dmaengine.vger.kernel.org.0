Return-Path: <dmaengine+bounces-7491-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04834C9F6A7
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 16:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC0903007CA9
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6410318139;
	Wed,  3 Dec 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="YyIYviDk"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D43168F8;
	Wed,  3 Dec 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774131; cv=fail; b=sjprOlP2MDp1TgKWCAaDw1qiDl0qc8XORbpgeLM9ZozLAPCAxJG8IE0XPsJTg91XiQmJVMmmKKNA1c7T+lwDEY2uzGGtV1K8Di60BhXUnSGgV8Gqua7Y0zMTUcw1oIceXhOwbQdSLmL9KQMNi/Sp3kdXL5o4BCG066lr1Anaork=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774131; c=relaxed/simple;
	bh=AikbRKWsyE0MKV3YnN7msN1j77+wc0HzS731FSsVQyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=djVR8o4LlOrjVUm6BFeet3CskB15GuWW08SVa3U/+DBdz2zJGuvNEWPg2xuyBcgG8SYrQnByraLYdXPBT9If/Y/d5MK2iefVgZovC2kS0Q3JR+6xxytud7o6SkqQa81NnJFbNJdpyjF9P6B+/eCHEN1VX9FC1Vh+6u63kmgnE3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YyIYviDk; arc=fail smtp.client-ip=52.101.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4dZBBMb+FfsVWHvCTFombgmbRA+c8QnnCtpMYkKxr5dEG+SyCZUZlGSU7o6YHk6KKC06uoSCbSDjXLyXkqpCp4zAq/Mq442cGy3dqg7RnzuN4zOnQxhavXFcLtDUOYXuptaPV02q7Mh/yFEzV6e9MQM/r5Cv9fXuv2NK9puydMYyywgYyfVSRsH0LB62DmAVZ71pckpY0a54PyGkC1RtO4JM9fUrr+V8/QopafkWlfNg3toj6z95kdSr/F2HeXJatQay1ZPviHWuxIBdHNPha6enVZy+LfQk8RLl49I/URsgWiIvjeqzjVPswc9TGk2d+qLxP2aDVHhbHlCQGzWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4UlnHMd66LR65Yuo4FQIxkZWxCHDl1MhTQ/bsLMEYo=;
 b=K69rWAQRbhjH4dhhL9DITVVesPN3nMj9XcNeiKWpUiuJEKte5wXRBa704VpSBXxX4PVFX8Ns6xrQFQwZGN3DMZ4qLQqaG47uUvssFh4GRlGteozGDkn1zJqXPeVp3PHUG8TMgnN+S2rQRWDKLFiT2b1xcsEtGWLdwYmPzRkCdvZEAWnz11PNGamAdxVdMhpzM9qpGBxD2mFwrXtZE7aTeIrRHCm764bncF5jwE6bEny0kJWfe1ZfonHy440K+Q3tjxTiUCfpIRh+hIm3zHMq0e1bFgB8OllYyLtwXvpKDWHAzJV63QfiEEQcenwtz4Ql44pTQl5CGNr5RiMM5CufcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4UlnHMd66LR65Yuo4FQIxkZWxCHDl1MhTQ/bsLMEYo=;
 b=YyIYviDkaPjnpOHAHsFMlfuRiN5NweVVci8R6b599VMreSlE9IbQ6G4T/UleE+62BrdQNBLuXaR0EiK+8MHS++cQKEO8NheZ4DeqjQcMvnCktLGKTymrRlVXzkaUgIl/igbmy4v25vnNxRRkXKd13O0L4RqakquWKEsnBcdkegQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY4P286MB6702.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.19; Wed, 3 Dec
 2025 15:02:06 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 15:02:06 +0000
Date: Thu, 4 Dec 2025 00:02:05 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, jbrunet@baylibre.com, 
	fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 10/27] NTB: core: Add .get_pci_epc() to ntb_dev_ops
Message-ID: <23ujug56kx6qwhqufjsfg6y3xhhwxfjcblcf5ekqgj3hrsk5bg@zj5a46nddk3t>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-11-den@valinux.co.jp>
 <8b209241-99a7-42c0-8025-e75a11176f1b@intel.com>
 <f6jo2z4dnk23dun7g7d6d4ul2rw7do2cugb7jtq4tfb4vixzsw@lmpl5p4kqxc6>
 <3c07161d-f1df-4409-a11c-b4a60afda226@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c07161d-f1df-4409-a11c-b4a60afda226@intel.com>
X-ClientProxiedBy: TY4P301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY4P286MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ff2656-af7d-4f9f-e030-08de327cec8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tQAm/EKBWYMl3p7RO4YviNSwnPziLTJL/T+pp/VGekhR+PHKa7jT6xeDyUve?=
 =?us-ascii?Q?p7bfB0K7zfWbVNUTbpa92jfOEz5IRjQr/bcjTR40+Kw060V6Pr8qgleEYbyK?=
 =?us-ascii?Q?XbsroOODOk6zys1ciCjvlInI23kI6A+m47oRmBIlpGObDRPhyjUimHI2gPOk?=
 =?us-ascii?Q?3Xz6B9LagXkMSUwwdn4BFF1RQEvOvWhT2OUC1Ex5Ocgr8VCxiTLlmwMrFJgE?=
 =?us-ascii?Q?OMhNp+DFNeisCU/gT0/9+E2FdrBLHEdLpTRd2rzxgWYC2n/ZBT+RQU9rO/ko?=
 =?us-ascii?Q?5+6BCiMfGGJjRsX65Tpwx+Gafn1FK3Jt6LCcnkXWjSCePpHobGAE7pE+cpNv?=
 =?us-ascii?Q?s2/YpRRMdfP/1HW4bj/3iFpnu5bXk6EhDN/rQHSpZYwOpIrSYXJ+7VE6bBWd?=
 =?us-ascii?Q?nDNh45JFRHgqagxJOr5Wa06QDscetxn6YrBkN/Jgip21adldfDpQo2NW2yhm?=
 =?us-ascii?Q?Ca+JWO3zMxj118sg8DNfT86NX2Entgxnqo5qFSJ92COmgm7SKGyJspVqquoZ?=
 =?us-ascii?Q?PC8dPq6KFKk4u6Jg8M9WHr1TaVMxDEwjDLL5sXzh+xbxINa6rjHaLQ9v+nnc?=
 =?us-ascii?Q?MbFl+u2Nl/TGDjPvedcA8/3kwLKPcqw+jVlGdQy9nYIZNF0T2i1vqQQ3gAQk?=
 =?us-ascii?Q?f1wI72tfLTu/sy+UlI8Tjrr6/2n48L2ePEBjLMinWxs81HYUK5wJ2Zdi0euP?=
 =?us-ascii?Q?YF/9rAAN6FBDTepM54HqaCr0e6GU1XTNBWqtgO7WGOxwgAUEiOhfhyXa7ZW1?=
 =?us-ascii?Q?9HYdPkgZGNmDhYaGtqS6+jxFr1ANAfU9+FPaC7I1Smw92sqOzA4I5t1uVxPS?=
 =?us-ascii?Q?Nc+MYUwf4RnCDz0ymjN9bGz+N1PeIehPu/aaOriybuW/M0OzlP6xgz5++KOl?=
 =?us-ascii?Q?U+d33Bmdqtgo+hFkFZdBqbCuJYs0x4K9k3sq5u6khTAqqwaPF7GstiXLoMNV?=
 =?us-ascii?Q?QVLYaWqnW5+NknQbCBv+W6/aCri9LgH97BZWZ4BLpTh1FyFg5A3q5/NQBPaK?=
 =?us-ascii?Q?UubYHVFxV307JVoqROvVXO8eUXjpuW+NrYJppauSbGYA4TbllSQ9TAhFVd4s?=
 =?us-ascii?Q?08fCrHO0Uhh2YBYrG3wCnN2Oxrvr/DiocEyCj3MgDRMzwbFnHhqT/vwW4Mh2?=
 =?us-ascii?Q?HPx/axNzXP0KjYJFuSJX0T3wndJNiHYYxDQVWKvWfSTecSEB3eNU0B+zGkpT?=
 =?us-ascii?Q?/YR/vIp+Cxbhk/aZBhpt+qcZgK9vpi2MVppGoL/dDEX6SwhOSo9+8Hph6sJp?=
 =?us-ascii?Q?LQvCGyQcfeX9mJ/cy9VpgcVlq0EQ374O7GxnFAVXWkG75IGf9EwiGCPvhZt7?=
 =?us-ascii?Q?Dre+l3lhkmadKXLOH/zBOUUeuxa9UetycWntOxpEu4F3j19WL4rQkMMQIE36?=
 =?us-ascii?Q?Fe2BfYYWTKAsr96x4nWycZ1vs6RS4WnibK/HAts/tVgUhv5VxczY5lznlOj3?=
 =?us-ascii?Q?tA9/i7TFiqcAM5+5HyFqX7/t3TpVbvJl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?StniflRQ1zK7PiU6Um/tm/1d3Lo96v8rjUHHpk8J0s/pKpADL/BL9fAM3g7B?=
 =?us-ascii?Q?QAwGBCaOr4v2F1M75To07p42VvsKm6qKjzkTYezgV5+cCi/zLrOCJIeE9Uq2?=
 =?us-ascii?Q?pwXViJPtSHDWNMVPUr/sW96bq0JhqpSXYMETBjochAZaRPakB9ucW5bolOuE?=
 =?us-ascii?Q?VfZzsSmdatzS6K2EpQgxWqVvRorAiAshIQsZqDLTics7cedadhgDUPzVudsh?=
 =?us-ascii?Q?oor/Bjh/3QVb1/a3i8ZqMTvo+nhY7W2df/rAcQQnys6aCS0zA5Jbn8IlrJpi?=
 =?us-ascii?Q?UrzvVdj3ZfF4ejORZQPOpzYXgKxCes+BU3EPU7uxIZOKBL+IBqUfY+FCLOAx?=
 =?us-ascii?Q?XTV9BngocpvK5RDhlvyvsFpiBiOFnFp6q/cdpH/YRZAqgU325+SMrp7Fe+w3?=
 =?us-ascii?Q?qQZBr2Hgj7xQ5i2rYPxgvBzCROxHxfUyNgi6B+6UtMXTdqRf81k45P0JBQaf?=
 =?us-ascii?Q?guI8pz9aptPv2Bx0cXwgKhiyWOgqFICXbeY50KoxpGXi/NTSRZFbxiQdqKJY?=
 =?us-ascii?Q?1ov2scNKGaT2m5R3Osr8pASjpbxFlApt70DPta6gcIsIn2FAK+kpMMKzjITp?=
 =?us-ascii?Q?FZ1F3Pd/BJDQ6UJde+1tavd4e8vNpfoY79IF6bNWJsVjImMUE0w/RTyCbKe8?=
 =?us-ascii?Q?r9gIA9xYcrPvMgO2bn1sA5inVqYv18ZW61iHV2nODhH0PbuZ+Q3/YncnvUcx?=
 =?us-ascii?Q?nmv/mXSjgTUmUF1AfRjnaOSuICyYVGMH4CpD76NBQ7ARjAKCREzWb9Vq1ohM?=
 =?us-ascii?Q?9nhbcDS0RjdThYWyOzR5v2eQWvhNRqvI4cpNRE3mS8B3bdK25U2IJx6Phx6g?=
 =?us-ascii?Q?TFDIWzaxKvdxE03WtJwcu5QNbC3aVemNTvVkTSJxOJ4HfW6jJHTg0pHS35D3?=
 =?us-ascii?Q?zV9ImBG6Q+193hIl6v1UE8FbOlmrs/MQyB2BB05Vr3hBNqEAWN2qPHBdR6/9?=
 =?us-ascii?Q?lLtgPE2QBsMAoyZ0dY+RSFLdErVtuOa7mqLLhDVzRLI1psiQKZZSTRp9btwR?=
 =?us-ascii?Q?1n/sgZIzLlCKbRC6Cukmh3IWXtvZE6Q4bYES6JQ27tGUl+5o6BsKAimWcKVT?=
 =?us-ascii?Q?argf8U4KnVm84y6oSMnv5idRIqFsbSd+cZN9dETb9sg9s/k5nCXwqN3znV3t?=
 =?us-ascii?Q?iHDXl+vto3BytIxyIQp0d15EJZW3AUPBqNDjd8lixzb3HrFxB8jC3ZuDRYdP?=
 =?us-ascii?Q?RNB8J+hsjm3SBUAxewXQjQFoAyZgDazk8xaFoMx49lSwWaTRI5vTitOY2Cuc?=
 =?us-ascii?Q?uHzmVf/sX/Mi4phwIBoCxYtpQckYkuo9A+ZjtOxBS6WKOqCr/piSu6bTX7KS?=
 =?us-ascii?Q?K+ODDNnxEiEc3CD4F1km80YdtdYycWbgai40RF7A1bvL1yS/Flbp5yjTMZok?=
 =?us-ascii?Q?JTY6DAtnqkYlG9CSA4pDRQFU53hgB2W/hiH/jMiR5AQ3PBDMbWuT9vJtEc5t?=
 =?us-ascii?Q?+H4k6d7DHSU8oqWmLOy/mj+bBKicHVAPajnM1EZUG7jxH9W/Et20TPGyTvjg?=
 =?us-ascii?Q?u8U3VwpeqTdBWf7zntOwo+PFkM2U/qG3XiSdmCWn86dPy5zmkn8Csuxo8s4b?=
 =?us-ascii?Q?sD3pcbwcYeQ62xo98UeAtnlUc18tIuUZsLrmrSRJgf+kjnEU3cQF0TTX/PEo?=
 =?us-ascii?Q?DDo1GBQ3Iy65hnc5m4OZBY4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ff2656-af7d-4f9f-e030-08de327cec8f
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 15:02:06.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHJfu+Vdy36xxdK3RMyUPZ3rO5GO78N/MVPIDOVw1VL6iakQWIZH6nO8EzAxWLOXrYxiw+aQa2ziNBUm/19oMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6702

On Tue, Dec 02, 2025 at 07:49:08AM -0700, Dave Jiang wrote:
> 
> 
> On 12/1/25 11:32 PM, Koichiro Den wrote:
> > On Mon, Dec 01, 2025 at 02:08:14PM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 11/29/25 9:03 AM, Koichiro Den wrote:
> >>> Add an optional get_pci_epc() callback to retrieve the underlying
> >>> pci_epc device associated with the NTB implementation.
> >>>
> >>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> >>> ---
> >>>  drivers/ntb/hw/epf/ntb_hw_epf.c | 11 +----------
> >>>  include/linux/ntb.h             | 21 +++++++++++++++++++++
> >>>  2 files changed, 22 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> >>> index a3ec411bfe49..d55ce6b0fad4 100644
> >>> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> >>> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> >>> @@ -9,6 +9,7 @@
> >>>  #include <linux/delay.h>
> >>>  #include <linux/module.h>
> >>>  #include <linux/pci.h>
> >>> +#include <linux/pci-epf.h>
> >>>  #include <linux/slab.h>
> >>>  #include <linux/ntb.h>
> >>>  
> >>> @@ -49,16 +50,6 @@
> >>>  
> >>>  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
> >>>  
> >>> -enum pci_barno {
> >>> -	NO_BAR = -1,
> >>> -	BAR_0,
> >>> -	BAR_1,
> >>> -	BAR_2,
> >>> -	BAR_3,
> >>> -	BAR_4,
> >>> -	BAR_5,
> >>> -};
> >>> -
> >>>  enum epf_ntb_bar {
> >>>  	BAR_CONFIG,
> >>>  	BAR_PEER_SPAD,
> >>> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> >>> index d7ce5d2e60d0..04dc9a4d6b85 100644
> >>> --- a/include/linux/ntb.h
> >>> +++ b/include/linux/ntb.h
> >>> @@ -64,6 +64,7 @@ struct ntb_client;
> >>>  struct ntb_dev;
> >>>  struct ntb_msi;
> >>>  struct pci_dev;
> >>> +struct pci_epc;
> >>>  
> >>>  /**
> >>>   * enum ntb_topo - NTB connection topology
> >>> @@ -256,6 +257,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
> >>>   * @msg_clear_mask:	See ntb_msg_clear_mask().
> >>>   * @msg_read:		See ntb_msg_read().
> >>>   * @peer_msg_write:	See ntb_peer_msg_write().
> >>> + * @get_pci_epc:	See ntb_get_pci_epc().
> >>>   */
> >>>  struct ntb_dev_ops {
> >>>  	int (*port_number)(struct ntb_dev *ntb);
> >>> @@ -331,6 +333,7 @@ struct ntb_dev_ops {
> >>>  	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
> >>>  	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
> >>>  	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
> >>> +	struct pci_epc *(*get_pci_epc)(struct ntb_dev *ntb);
> >>
> >> Seems very specific call to this particular hardware instead of something generic for the NTB dev ops. Maybe it should be something like get_private_data() or something like that?
> > 
> > Thank you for the suggestion.
> > 
> > I also felt that it's too specific, but I couldn't come up with a clean
> > generic interface at the time, so I left it in this form.
> > 
> > .get_private_data() might indeed be better. In the callback doc comment we
> > could describe it as "may be used to obtain a backing PCI controller
> > pointer"?
> 
> I would add that comment in the defined callback for the hardware driver. For the actual API, it would be something like "for retrieving private data specific to the hardware driver"?

Thank you, that sounds reasonable. I'll adjust the interface and comments.

Koichiro

> 
> DJ
> 
> > 
> > -Koichiro
> > 
> >>
> >> DJ
> >>
> >>
> >>>  };
> >>>  
> >>>  static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> >>> @@ -393,6 +396,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> >>>  		/* !ops->msg_clear_mask == !ops->msg_count	&& */
> >>>  		!ops->msg_read == !ops->msg_count		&&
> >>>  		!ops->peer_msg_write == !ops->msg_count		&&
> >>> +
> >>> +		/* Miscellaneous optional callbacks */
> >>> +		/* ops->get_pci_epc			&& */
> >>>  		1;
> >>>  }
> >>>  
> >>> @@ -1567,6 +1573,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
> >>>  	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
> >>>  }
> >>>  
> >>> +/**
> >>> + * ntb_get_pci_epc() - get backing PCI endpoint controller if possible.
> >>> + * @ntb:	NTB device context.
> >>> + *
> >>> + * Get the backing PCI endpoint controller representation.
> >>> + *
> >>> + * Return: A pointer to the pci_epc instance if available. or %NULL if not.
> >>> + */
> >>> +static inline struct pci_epc __maybe_unused *ntb_get_pci_epc(struct ntb_dev *ntb)
> >>> +{
> >>> +	if (!ntb->ops->get_pci_epc)
> >>> +		return NULL;
> >>> +	return ntb->ops->get_pci_epc(ntb);
> >>> +}
> >>> +
> >>>  /**
> >>>   * ntb_peer_resource_idx() - get a resource index for a given peer idx
> >>>   * @ntb:	NTB device context.
> >>
> 

