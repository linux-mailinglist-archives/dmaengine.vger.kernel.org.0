Return-Path: <dmaengine+bounces-8288-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 949FED25B69
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D4B3018965
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C483B8D55;
	Thu, 15 Jan 2026 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UoifN79U"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222973ACF16;
	Thu, 15 Jan 2026 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494093; cv=fail; b=Zqhjgc21ay+IQKLHFKaCs02uVv5aXJujdg6qbRfH62wiqOuTf6PZKrkSjWSwj6lqZyUumBlTJqD/jQ1iqJbGVuK4IQGnEG35jrOgeA10UUtQJDAAA5C4MjQp9UETGykcPKOzaD4vEByhdk4u0puipm0A7Z/BsGovroeyb57xnoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494093; c=relaxed/simple;
	bh=h2rBO/n1yCMGJpdN6nFjWBAM5lMJs+uG5m6BH2Gie5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rtj1evH2L2BIPgC6MrvBDuEiNsd8SvT23DVmEDPVaygkg7doCzwCOaZq14OpQBrjvWDN00Y14YoAczc7XTojn85/Oy3q5gie5sAPahNV93t1RQ6kHGcr1q4I9jl3puHQUONhgSUfSKJGfBKXIf3YG+c7//G6M312RRnP/b+hFXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UoifN79U; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xt6/kNEKhWWXd/maLZ39AhBO6FMBhfSuD6O6rwD5KZZjz8lZPlmKGqwi/fnouNeI4D37i93IRR43rTq02s7WQaGLWqNWZMwcs6/+8U/djMtXPOEg7iLn9j80SQspXxBwRl30qfz0C5ORx4zzJn5kelp5EhV1JXCwNuQAPFNwkjRkJ63uvQdvOy1zLF1QWG2zkWhU9ENoJjfqCNb94GI2uNMvpjCcceGGn1/BnXFmJsEaPyNamJ/sKwXcXXds0AdTRtPshckS8EgYfvUAhgpbCZWQU8qt891S0eylkYVaVI35n8oN1hyItcRv6zlrxacGGtjiKPxkKU1qzQ3dFl+bpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1iqWB1hCirqbfunnbh7VZ/lkDzeGUL6TOaS0lTjbrA=;
 b=aXrs7uP8DDL7jQOAEDcAXYtv/pp36GUVFblMI7YJCA0sWdEwjy3JX/BWvakIxuQv17x8TSIc2mrJciebwI7F4mVqWwluCGfG31Gv4ZY/XhS27ldJpQ3owNahL5XJUI8io2ZMjbplYcBtOD+7t71R/yJpTzEkKMURiVm51upYeRaimrUYTiG8Uh+VniV0TG/6nuRaMKVDbHfWe2Kl25VP/ksv/oMiYEVQ5amIe0WHnkPTjTwbAmMCFKWV8s4IbwJ0WIs9CrwZw8ezhXTJxU5OnjSZ5GuZjR+rHXKbfuy6cj+hDryi+JOzIUU5JnpvPSdRxsVsyrXnAewmrDfU0fp3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1iqWB1hCirqbfunnbh7VZ/lkDzeGUL6TOaS0lTjbrA=;
 b=UoifN79UGc5kfoKPqfPi8Ye8pRzb8rCbKKcAtqDXh7aLJqWRVozAPjkErhpyCUc6rolJ9LLiuC9hSH2JSnL1xohkoYLUzqt7aEBWmDtx57v3/9GcuEMoq6aow+LaxPwwQOpo1IsYovoZecbDSSWu7D0tISCcJCL9Y4I8LnMTBkdVN4bPVYxBa6GL+kRb0SCb4LDE561aeLmxbwolWqAxSiNryONxMJiaoF4eoHfc2Tc+XuRYvlaWZ961vG/bbOSW+eL6dcrO4E0byQrMR+oDbyGfz3F9lba7iA2CR6uPLsG6VjdHNZ/T+gCNx4khaQtXrknNor9X62mQ3x2OT8bPaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by AS4PR04MB9411.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 15 Jan
 2026 16:21:25 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:21:25 +0000
Date: Thu, 15 Jan 2026 11:21:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <aWkT/TDoLNnGUNlG@lizhi-Precision-Tower-5810>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-2-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109120354.306048-2-devendra.verma@amd.com>
X-ClientProxiedBy: BYAPR07CA0081.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::22) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|AS4PR04MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c54f7d-f742-4777-2074-08de5452210c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BWdsooQxztBQB83bUKKtWc8JkzhLDpCKmgvG10k0Lpd/IV98u7oR35I5N7di?=
 =?us-ascii?Q?PdtJ3/S7pyYFAs3jqQUfC4vn6QFPIw4CSRZNYJSET1HpuRlcgwLwgQwS9cqc?=
 =?us-ascii?Q?KMx3/CL4BMzd5nN0gzXaLyC8FvnPA9tilK8MGJ38yo43giFB9Vjm2mSiQaBX?=
 =?us-ascii?Q?odseamcxXbFK3iZjw+jmxHUfZH1TL+KdRFvECGjCps+d+TBtzHHp4kttQ5h7?=
 =?us-ascii?Q?21T8o9lU/xVuZJj92L1wZrYOxX+F4R2vmcjPkSAq+HgNc4CGGQDxOqiqaoK5?=
 =?us-ascii?Q?QTQNmF2KXAa6Vveq6DXdYKr3U4IKw5Nq76jWgOQXIYwi1PKmqFXFaQPfCywb?=
 =?us-ascii?Q?R9KTJQBXcFiSzWuK2gv8Y/i0Cb1owArkkJRY+hDDvTfu15Kv4JlzWzQXVHWT?=
 =?us-ascii?Q?aFQpEePyoq+tvv6FruZ+DM597mTe37AvRIppvDos4jl1srkmt2nTAaid0WyA?=
 =?us-ascii?Q?ox/fDN7mlX0Bqy8npJ+gbGZTFrmPdRzNTxIk0H9Z+RyzJzegz5qs06EPAKOM?=
 =?us-ascii?Q?ioLGOAkKps0vDg1o3HLV246jHM04JIOnuuQDILQpSNA4bo71b3wzDwDTgKqu?=
 =?us-ascii?Q?scbxWy6NErRr2xjGzFEPW7u6nKvqsO7utw6NQPkH2Apgf19H9jAiBv+xhIvv?=
 =?us-ascii?Q?IwlhAotvbtzDUReV7Iku+4F5TT01ST8ZrlJLVPYN1JMagA4aqGTlA1oo+y7U?=
 =?us-ascii?Q?LI4pxHjRlR0QEu67Od9zMcuv5nCN8eDp6SlURMQMC/b6SWHpjctlt5n4MaBm?=
 =?us-ascii?Q?/IoR42Kup3/C2q3e/IGQqKgc2WIaOk+oKS6j+NMDqzEmfyzJhCIdyXUvIt9C?=
 =?us-ascii?Q?Vq8pkdzif8qSAnL/FJ+CixXerzcg4o5fDbVJWP4G0rjMyZQnADuIbQKD94FF?=
 =?us-ascii?Q?9vefUCxpYUR5Av2mfHMRMJ4VhY+hZpNJ60B2KgsozDRcyBvoDZuQU5SrGYqf?=
 =?us-ascii?Q?+cSCQwGbk44GLvZkzc4GianmapDuIMMfX/gRGstOC9KFbpOZjrYJiQa6Il0A?=
 =?us-ascii?Q?6WFQeuyc5iGyX00OLXVDz/1p2Mx7m62YSpVBIKs76zl1w+rdCZiZrR5sBJ24?=
 =?us-ascii?Q?7I1xYxLX+IrhS0kSGeRkhTeWXb/SPjiFse8Z5C1ZSydk2YRqkwiXq2LKAP5J?=
 =?us-ascii?Q?X3JNzA8qMrLIremNu3iIHLgOskXXOWRmeNiV2dmmVRYU11QY7Vb/CgU2TlXE?=
 =?us-ascii?Q?mdDMaSC/T+zTTaF/p95Sga5YhHfQN4slqJPMqSu0UaIhSiy/sxBbUQEsao6e?=
 =?us-ascii?Q?Kl/68wy/8Zsefjmz7A+quqDVSInvT28pwgXnSYReJTocu3gXpkIAxEQYhW3J?=
 =?us-ascii?Q?2j+dh4rVBN5yLrIPfwpqyU3SbJFt7bBp8zdaJHiIl1iyn/JOVU0j/zUklC9v?=
 =?us-ascii?Q?xlA57Po4fIs6tC1DULR4keJ/puCUeLiWntvvV2I3hrUiQkoJ4DobmcZBywiN?=
 =?us-ascii?Q?DGujiJ2VK67Gr2XSV5uq1Lm3RmXBBAkaGTKBrT/9gmMz183yop7DJRGne4fK?=
 =?us-ascii?Q?NT6UTpP8sDQW3hDk5qcMXKNINw3DYQx9PSebb8gTfNjbn9HfqRK/glQWhwt8?=
 =?us-ascii?Q?6EnHKhePw0OfAB3KpfVUbQhsYU4P0vCRuKtfu0di8ev5CJDWQ2GrwJ7qjqXd?=
 =?us-ascii?Q?OqAEKcfD16RR/WJ8cN9z3ns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqmaYXD3/mrQh3pLmZVo1JjxHn83+3Y+9/4uA70dU3FHJ21tNFYCAfHOWYd1?=
 =?us-ascii?Q?RD66S2N7LIB4Xg6ZWdclG5SC0TgkbYc5YtmsPqTI4YPvLRtKXX3KDjiNlEDE?=
 =?us-ascii?Q?aGDLXqRxkxbdXURHOFIfGEHrgDv5FDm/D9IzWJzc8Qw4P5SdWW4gQGVMu3+V?=
 =?us-ascii?Q?Zd3Idw5lMrbO/9AdQvbbfS84bbMUF9eK/yyuBloShNTDEiNENXjpWkF9g4MW?=
 =?us-ascii?Q?vxJdBAn0Fe5UDGmnH2mON8yXkG3svUnUm1UQGi8d1t/jG+V7qfXHPYwKWvKF?=
 =?us-ascii?Q?GGJ7/HqXwniWl9qIU706Oj5ovZIALXlIG4ZpgyRnG3fcHGhivo9LHgHdjqv+?=
 =?us-ascii?Q?ti+legvEX3sLH7eGFQHPgUfUb1oK0RbBQ8N/Ayn9VI6k+qjwbHj7HR0vMBWl?=
 =?us-ascii?Q?akCGT5wP2yXBJ7Z+KSyJdADdULPoRvfqyBn76wGYiQWjiUfTlOumoR95VnAZ?=
 =?us-ascii?Q?1FqxCIl8TI/SEIy8KfYxFeogxYce7DOcE5S4quKv9WutJwvyVq9DLm0pqUHq?=
 =?us-ascii?Q?XL+Ktzh2a0SulLHZ5QR6/7WxPSwByWTDk0mhmYKYxtpeg76d4+gyB9ZEAPGO?=
 =?us-ascii?Q?DzNbl3spLDoITsk10q29SIGersVf6E6rTx9eJyCydezKPZB68k9w7ObpkzZr?=
 =?us-ascii?Q?6EYwkvcaYqn+F8cg8MNo0gp318m3IcsRkqC9LD9zIiPoFn8h9xvzePZlOfTu?=
 =?us-ascii?Q?JlK5zAAQk6IUpti0W91XnQZekLozivGVOGITRSru7egyolnPCaN42vOebNQz?=
 =?us-ascii?Q?t4y79rWLT5brrGvHlqrh5sqQxitFj0N7KjrsaQngjKMu/p62RBFoiPbnYN8V?=
 =?us-ascii?Q?WHridd8g6u5gad7Z+BnXFD36rCQZFApukRlEM1XqQEsEBYXIBEN4AD69b1vv?=
 =?us-ascii?Q?VAP2IPqN1kHTnZPE6sDt5k1nZaxiXkvJmekuvOUlr+dXSfPLr2R2w0Y1/jIA?=
 =?us-ascii?Q?jErKRzycahKKT7s8zlsCYEKNM3gE5WmpO6ZmKqkLaJzN/uq5KIZdWUn8xVQh?=
 =?us-ascii?Q?hjPSc2gmQ5hAZQAiI6k9Rkh9W+3p6Yqs35gZlRTvADg2VAk17HWMFvpir0FA?=
 =?us-ascii?Q?1yI1aD+9qEmiipapHf/xMgbUirkO95GXAMRwFbnHp9G5pN/wA9yuQLE//j7p?=
 =?us-ascii?Q?ncwgfQKKiG4wN3JjmP1v+s7qs4PkaGkb34zI/OIJh5fnFYOnYJX1HwZwl637?=
 =?us-ascii?Q?C4yh064FnmDnpWkpOtEhFpV2jfjB+JZ2akHPPGy/4aYHytIQleQJkEHa3mv4?=
 =?us-ascii?Q?zdj748TEfUkcx0SgAUREVSIZZegvLO89MCn2/e5cUfeD12+bbXxs9n+Z9xZ1?=
 =?us-ascii?Q?bi4B5b+xMIW5CukQv6iCy9lQmzo9KU4gAT9xx/3E8p8A/3mqh27ff96KKQ9X?=
 =?us-ascii?Q?MSFgIN8FDrD5wiSZc1ftr++CfHAdUEt5TJirMNp03QYXSPRSPgBFGLFH6sbF?=
 =?us-ascii?Q?7B3/ThiMSJADKhb3sb5KhpBI47vDTz9jaagTet3b82BDi6W1d+L3V3KSF7Wb?=
 =?us-ascii?Q?5ZPVhyEce2FzwdFfVJ6ntlGwqu9TfWLZkQuzpLITZZQ21KqPmGc9jO5DlBlT?=
 =?us-ascii?Q?nPowCXAPHOiFWNeg2kQ7B4qISO5MSgs6P4tYoUJskrhK/37GrNDoiO2iCZ9S?=
 =?us-ascii?Q?Cpqkqoi2oUoA7QxLpbVFO8IbSBrt5Pyx4EleSJxJApf/NFssUlB+e+v6ozDh?=
 =?us-ascii?Q?4r70O1kt/eWLvM++JFUAmexK7j5s6pGD/Hzbiu8VyhSzelAbdORXEXu1/dng?=
 =?us-ascii?Q?sw8WlUrvTQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c54f7d-f742-4777-2074-08de5452210c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:21:25.4106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNTEeO562ri4ZjbvzhqIjirHROccJdlMCWxuwOgFlvgx1dxHiosJwDt+19hc8X+fvV5fo8QzFQ1HwIhvWpCOlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9411

On Fri, Jan 09, 2026 at 05:33:53PM +0530, Devendra K Verma wrote:
> AMD MDB PCIe endpoint support. For AMD specific support
> added the following
>   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
>   - AMD MDB specific driver data
>   - AMD MDB specific VSEC capability to retrieve the device DDR
>     base address.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v8:
> Changed the contant names to includer product vendor.
> Moved the vendor specific code to vendor specific functions.
>
> Changes in v7:
> Introduced vendor specific functions to retrieve the
> vsec data.
>
> Changes in v6:
> Included "sizes.h" header and used the appropriate
> definitions instead of constants.
>
> Changes in v5:
> Added the definitions for Xilinx specific VSEC header id,
> revision, and register offsets.
> Corrected the error type when no physical offset found for
> device side memory.
> Corrected the order of variables.
>
> Changes in v4:
> Configured 8 read and 8 write channels for Xilinx vendor
> Added checks to validate vendor ID for vendor
> specific vsec id.
> Added Xilinx specific vendor id for vsec specific to Xilinx
> Added the LL and data region offsets, size as input params to
> function dw_edma_set_chan_region_offset().
> Moved the LL and data region offsets assignment to function
> for Xilinx specific case.
> Corrected comments.
>
> Changes in v3:
> Corrected a typo when assigning AMD (Xilinx) vsec id macro
> and condition check.
>
> Changes in v2:
> Reverted the devmem_phys_off type to u64.
> Renamed the function appropriately to suit the
> functionality for setting the LL & data region offsets.
>
> Changes in v1:
> Removed the pci device id from pci_ids.h file.
> Added the vendor id macro as per the suggested method.
> Changed the type of the newly added devmem_phys_off variable.
> Added to logic to assign offsets for LL and data region blocks
> in case more number of channels are enabled than given in
> amd_mdb_data struct.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 192 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 178 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 3371e0a7..2efd149 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -14,14 +14,35 @@
>  #include <linux/pci-epf.h>
>  #include <linux/msi.h>
>  #include <linux/bitfield.h>
> +#include <linux/sizes.h>
>
>  #include "dw-edma-core.h"
>
> -#define DW_PCIE_VSEC_DMA_ID			0x6
> -#define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
> -#define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
> -#define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
> -#define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
> +/* Synopsys */
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID		0x6
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR		GENMASK(10, 8)
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH		GENMASK(9, 0)
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH		GENMASK(25, 16)

Sorry, jump into at v8.
According to my understand 'DW' means 'Synopsys'.

> +
> +/* AMD MDB (Xilinx) specific defines */
> +#define PCI_DEVICE_ID_XILINX_B054		0xb054
> +
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> +#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)

These defination is the same. Need redefine again

> +
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
> +#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)

I think XILINX_PCIE_MDB_DEVMEM_OFF_REG_HIGH

> +
> +#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
> +#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
> +#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
> +#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
>
>  #define DW_BLOCK(a, b, c) \
>  	{ \
> @@ -50,6 +71,7 @@ struct dw_edma_pcie_data {
>  	u8				irqs;
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
> +	u64				devmem_phys_off;
>  };
>
>  static const struct dw_edma_pcie_data snps_edda_data = {
> @@ -90,6 +112,64 @@ struct dw_edma_pcie_data {
>  	.rd_ch_cnt			= 2,
>  };
>
> +static const struct dw_edma_pcie_data xilinx_mdb_data = {
> +	/* MDB registers location */
> +	.rg.bar				= BAR_0,
> +	.rg.off				= SZ_4K,	/*  4 Kbytes */
> +	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> +
> +	/* Other */
> +	.mf				= EDMA_MF_HDMA_NATIVE,
> +	.irqs				= 1,
> +	.wr_ch_cnt			= 8,
> +	.rd_ch_cnt			= 8,
> +};
> +
> +static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
> +					   enum pci_barno bar, off_t start_off,
> +					   off_t ll_off_gap, size_t ll_size,
> +					   off_t dt_off_gap, size_t dt_size)
> +{
> +	u16 wr_ch = pdata->wr_ch_cnt;
> +	u16 rd_ch = pdata->rd_ch_cnt;
> +	off_t off;
> +	u16 i;
> +
> +	off = start_off;
> +
> +	/* Write channel LL region */
> +	for (i = 0; i < wr_ch; i++) {
> +		pdata->ll_wr[i].bar = bar;
> +		pdata->ll_wr[i].off = off;
> +		pdata->ll_wr[i].sz = ll_size;
> +		off += ll_off_gap;
> +	}
> +
> +	/* Read channel LL region */
> +	for (i = 0; i < rd_ch; i++) {
> +		pdata->ll_rd[i].bar = bar;
> +		pdata->ll_rd[i].off = off;
> +		pdata->ll_rd[i].sz = ll_size;
> +		off += ll_off_gap;
> +	}
> +
> +	/* Write channel data region */
> +	for (i = 0; i < wr_ch; i++) {
> +		pdata->dt_wr[i].bar = bar;
> +		pdata->dt_wr[i].off = off;
> +		pdata->dt_wr[i].sz = dt_size;
> +		off += dt_off_gap;
> +	}
> +
> +	/* Read channel data region */
> +	for (i = 0; i < rd_ch; i++) {
> +		pdata->dt_rd[i].bar = bar;
> +		pdata->dt_rd[i].off = off;
> +		pdata->dt_rd[i].sz = dt_size;
> +		off += dt_off_gap;
> +	}
> +}
> +
>  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  {
>  	return pci_irq_vector(to_pci_dev(dev), nr);
> @@ -114,15 +194,15 @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>  	.pci_address = dw_edma_pcie_address,
>  };
>
> -static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> -					   struct dw_edma_pcie_data *pdata)
> +static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
> +					       struct dw_edma_pcie_data *pdata)
>  {
>  	u32 val, map;
>  	u16 vsec;
>  	u64 off;
>
>  	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> -					DW_PCIE_VSEC_DMA_ID);
> +					DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
>  	if (!vsec)
>  		return;
>
> @@ -131,9 +211,9 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	    PCI_VNDR_HEADER_LEN(val) != 0x18)
>  		return;
>
> -	pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability DMA\n");
> +	pci_dbg(pdev, "Detected Synopsys PCIe Vendor-Specific Extended Capability DMA\n");
>  	pci_read_config_dword(pdev, vsec + 0x8, &val);
> -	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
> +	map = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_MAP, val);
>  	if (map != EDMA_MF_EDMA_LEGACY &&
>  	    map != EDMA_MF_EDMA_UNROLL &&
>  	    map != EDMA_MF_HDMA_COMPAT &&
> @@ -141,13 +221,13 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  		return;
>
>  	pdata->mf = map;
> -	pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
> +	pdata->rg.bar = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_BAR, val);
>
>  	pci_read_config_dword(pdev, vsec + 0xc, &val);
>  	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
> -				 FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
> +				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val));
>  	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
> -				 FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
> +				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH, val));

If you don't change macro name, these change is not necessary. If really
need change macro name, make change macro name as sperated patch.

>
>  	pci_read_config_dword(pdev, vsec + 0x14, &val);
>  	off = val;
> @@ -157,6 +237,67 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	pdata->rg.off = off;
>  }
>
> +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> +					     struct dw_edma_pcie_data *pdata)
> +{
> +	u32 val, map;
> +	u16 vsec;
> +	u64 off;
> +
> +	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
> +	    PCI_VNDR_HEADER_LEN(val) != 0x18)
> +		return;
> +
> +	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
> +	pci_read_config_dword(pdev, vsec + 0x8, &val);
> +	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> +	if (map != EDMA_MF_EDMA_LEGACY &&
> +	    map != EDMA_MF_EDMA_UNROLL &&
> +	    map != EDMA_MF_HDMA_COMPAT &&
> +	    map != EDMA_MF_HDMA_NATIVE)
> +		return;
> +
> +	pdata->mf = map;
> +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> +
> +	pci_read_config_dword(pdev, vsec + 0xc, &val);
> +	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
> +				 FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> +	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
> +				 FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> +
> +	pci_read_config_dword(pdev, vsec + 0x14, &val);
> +	off = val;
> +	pci_read_config_dword(pdev, vsec + 0x10, &val);
> +	off <<= 32;
> +	off |= val;
> +	pdata->rg.off = off;
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev,
> +			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> +			      &val);
> +	off = val;
> +	pci_read_config_dword(pdev,
> +			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> +			      &val);
> +	off <<= 32;
> +	off |= val;
> +	pdata->devmem_phys_off = off;
> +}
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> @@ -184,7 +325,28 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
>  	 * for the DMA, if one exists, then reconfigures it.
>  	 */
> -	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> +	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> +	dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {

dw_edma_pcie_get_xilinx_dma_data() should be here.

Frank
> +		/*
> +		 * There is no valid address found for the LL memory
> +		 * space on the device side.
> +		 */
> +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> +			return -ENOMEM;
> +
> +		/*
> +		 * Configure the channel LL and data blocks if number of
> +		 * channels enabled in VSEC capability are more than the
> +		 * channels configured in xilinx_mdb_data.
> +		 */
> +		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> +					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> +					       DW_PCIE_XILINX_MDB_LL_SIZE,
> +					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> +					       DW_PCIE_XILINX_MDB_DT_SIZE);
> +	}
>
>  	/* Mapping PCI BAR regions */
>  	mask = BIT(vsec_data->rg.bar);
> @@ -367,6 +529,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> +	  (kernel_ulong_t)&xilinx_mdb_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> --
> 1.8.3.1
>

