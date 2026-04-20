Return-Path: <dmaengine+bounces-10043-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK1JJ7jl5WlkpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10043-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:37:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC534283B3
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C164F3011BEF
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB14388364;
	Mon, 20 Apr 2026 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RYGQqSQ4"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013069.outbound.protection.outlook.com [52.101.72.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D6377558;
	Mon, 20 Apr 2026 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673977; cv=fail; b=rQxmZ10YtKkExzkgr2rZC7wFNDdYzjgVC/Cb/3x2PE0cCQ+XZKPE9fQYYyqbK6A0fMQA1Bc3tOQquIP7Q1eyZfYmp/mhrSCuZBWNbUTIfdB0VVrJWf4sW+chAtnHUUKFmejt32zPsvAQgt9ZLplc+73xjgzUQFE/jObxk4b168U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673977; c=relaxed/simple;
	bh=HeYH2rx44hfK7YLOj76UWaZYPDRS50ZAoF9JxZI5MoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kVkqT3RttdTbaM/VhWh4P8lzRSlaJuDngb+Hd/4x7aeuXHum16XNnvh7uPcVvg8pH6so4zd7v84C2W9O+jZIL0U/wRRKiU35/oLXqz2dlbL7dm9ArGH3Vg3cg91bRmISZ0lsih2CF6KTfF87RNSi5d8ilvLRbkRiGo81h8ELpWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RYGQqSQ4; arc=fail smtp.client-ip=52.101.72.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ytz8vVvKVKxiruaAIOnoc/O/dHGFXcMRur6N9T7b4YlIUmh4jUKeIIv8ZQhi+82vsAVVbCjvRIkqW/ZSiNfLqQdE8eJGs6jUSQkVr5cQhMTDk57Qx7MgYSAynTscPJmFsiP/b8lZIp00Cec39P5p8RCS9lqVdkfNNyDW+RJkYrzrPKkYDtp90uLX1U+Wp0KlgkwQTrj9q1lhFKR5cPeof9KUZ7O4SmSwglWDKvUP41LECCAT0xkkA71vTt90HXj8fC8+xKG6TLQxwIElzHqz//1gFxL/sXhFtw0Kq4ZSPCAXBq+tJLA0775QQit/65Z92HLKyrkg7JxqqgNw9+8xcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkizAcAeX4xFiBs4dP+IGyQgOP/vkg7Pu7kzwyrcvQg=;
 b=A0gv+KyxkGHS+SxLzf2IKIaVpw6yT0kfUFkyyR7dlcpMY5I6iEpowzU8U2lsJUOyWzXC8Rznd/VT14ejXES+ZL8K8Q06Glk/TFnLZYRSSMXaymXRcuxGnHAW6cYMCuOc13LHwROpzS4Mx0/BL0fGXjLd2rUjGRUD+U5xJ0c1QgGNe4YaMQhfA86I7q9WJsqGsuNATWIfgc8ig+e0vu0/lNMasey5xyN8QF2lFL76YTcwOcd7eZCEMxaDJfiIUruQvGl9VsvrstTJCbl1Zt9fbEL4iUSAMyDQKm7HdlE46OfQHZENwbzNBAl/IusBPvmn35H+WI00X23NuK2F+zAR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkizAcAeX4xFiBs4dP+IGyQgOP/vkg7Pu7kzwyrcvQg=;
 b=RYGQqSQ4ujpUsbu/ccttIBy8TDERU797DpI1jwXEJC/M45Nd/5R0+TdJVdeGQss/zmXL5EQjE2UOGvC/xAqLLkzEx2sp+9ovduxAjukXVNYLlpo3Ngewqkak79Pf6inhVUIftW03jnvw2Qp2xxZP3l9PzhUUpvtT1jlzzL38ebA6SmMXVRMMdZdq1NbYKe8AbH6u8H9zUXWdJPrd/g44Ikh7/nZRxRCDbdmEFUaEreuSo1wZvNmyZotCEscXr9Mh5syPjCshQYDln1s7y4ZjaKDLzXDstS5m6N+jaybbdN7xSErsDDFy//5eN6ouykjcHFXcuEMOzvc8Bq89PcpRKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB12106.eurprd04.prod.outlook.com (2603:10a6:150:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 08:32:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:32:52 +0000
Date: Mon, 20 Apr 2026 04:32:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com, John.Kariuki@amd.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 12/23] dmaengine: sdxi: Add descriptor ring management
Message-ID: <aeXkrudhvhTRtS9d@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-12-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-12-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SA9PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:806:28::34) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB12106:EE_
X-MS-Office365-Filtering-Correlation-Id: 235cc6bf-2ebb-461f-993a-08de9eb76985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7KQcjFHdBrSdVDxSGxpjzuUgtTiV3h3csWaKH9jwEeUjune9QGbfVJK9JOIvdhcdaNlcUUR62CIQXDW/LZUT4HhL+nD8zMiH3LZtolWKludvDdJJWKytIdhM3weSiKub5SNZYutisbQeIKzsrCrwsw6swQMQdODkn1J/jqEAqDZWbHbZRItFF5HpmohoQ/goBx+0e1J3i5aNIk0ZYKBvsH/poCrMBcJ3mfN9VhFHnG/p6Fmoep06M++ETcGsDY075aPkyvkRntjv7VUyAV/057BGHfrTXHCuTe5kwKYfMcjLFWCs+YMRfvxmXcEqvdAk+IGWNQK6S6hiMow2ROSOzDSszGtJeXePsMdk6vp9ZQ2gQUooZ1XC1ttypKpGkPY0WBV9hW+1AGeMuhXnJFDIpyqQ8FVe0vt062iwkuRfQta94TMcw/i1REW+n3c/dyrYOoqjaAtjJ5Sfr5lHK4rlBM9nb230xWZJqn+bKMw+FTgDVu7FU509gb+sU5RgPwocFKjtMudmuGgEcMxYyj8NhXjIAhmRKOS2OVHrHhALSmuF4d5sWIwJDDJ85q9/dRUppveRk0/bfANBdRGWeJ/DtXZeureITv73ndI9Gp/cRagCQlpA82kMR+hZo72f0nRTLhe7w9GIuWSgq3JG1fAxmVhxO8O/E/GCZ0ELFCuMQvLjYKHJCL+x1RkYHlmyrnVUYXcrdUlVVMthdyHkMzu8J4G1LizoqFxTuP/R3JI5A7thorii/Jl/dj2JQ6yuT0jtaWxk9QOv8bfSxGg1pPsed9WYJuf2xAuCjL5zIEh0PqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1rwYkg4ZFVr5Xe5xmBy3pxMSxkW6GAfjconbB9oafCxAHAvKdfGIOlxATkz?=
 =?us-ascii?Q?qwnlRB/KhuCL8qx/7lWMw+ke7aSoLELN3UijtHSQsIXYgts2Fh5E2oVzEEIp?=
 =?us-ascii?Q?1x3FoZzzbWXVwgENzICfV32eOZAZonvBQOhoUDi/R4UoeQSOH8EJa2UNYUT7?=
 =?us-ascii?Q?92SYiCwABXaGNakanDEKmRceMg7cs/0uqDFPTyD9XXJsAZQU/qoWL8saiqD8?=
 =?us-ascii?Q?9IW5NewaiSVVHPCB+2lmjDyAjSyvtXyNnvkYqInr9UjI9B7sLq3r4IFUWydM?=
 =?us-ascii?Q?KyWhqllh4I7t5xGVtcaUX98hYpZxoPGTZs9H6hC6gZx12EDVIyIGwYYccS5E?=
 =?us-ascii?Q?5L1PVJQVB8khuHqfaF2UOzXXnlG2HjE8GIB/gToZ+zxPK4g/Edtwco5MVNJD?=
 =?us-ascii?Q?0cJmJd4ta7NSMCM+Nfh6fksRPFMX5v0NnVjjMucPfYM7m76eRaGCvi67yr2J?=
 =?us-ascii?Q?tsDqapWjuLO76J3H4KqyceRJyUjcFXUwB4KX7NsZN82iQUDbPRN099BHSvl8?=
 =?us-ascii?Q?CMNsvc+n6eQEolIW7LV9j9d/oJ9nKHKMn4TfZrzunsihKxkCaaEPx6LJFxOy?=
 =?us-ascii?Q?kZ22xls1PydLmeMNolDIYlzTMSOUKtUCKKhdz8r0LYIsb+bOWmvHJyuZEQ3a?=
 =?us-ascii?Q?FOuDqD0ICtqko0m7Bh5dTTbLOgx1sfLZu0o8X3f1hxWSdA9VsBtdkuI1ZD5N?=
 =?us-ascii?Q?CfM90NxEkrkC00FoiQZCiVsqXmIH3kVnnMM/e1TlkRxFaKQkPoVTnoB7WDmV?=
 =?us-ascii?Q?gpYRsvbI4j+rZsmOU0m8ISHkUh9z3xT3QmROeVbuhI7ah7cinKZqeqPptkXh?=
 =?us-ascii?Q?SsDyl+lLrZ/Q2fnuEXIKcAbG6pUVslM9hO5ac4+V+9vxCf49TzQmyM6qdTQc?=
 =?us-ascii?Q?by74O2AKL7OJ4wL6U6cJb0hWVHRyWC6MW5wdQtezZtcFBxt5RFPJKDqM8Hr2?=
 =?us-ascii?Q?vcS33vuft3hna1vZq34yTDqUcruWV4/Z+enHv3KvvbbcTSQUR1Kzj1DYZPoo?=
 =?us-ascii?Q?VywumOL1z5GOxF80sIppYQixKREB06fAR0fdPMoW1En9XpFfd82/Tbg+EQHK?=
 =?us-ascii?Q?KlWPXPUXrR8hpCFx1BAHlJidDSx+qx1IkjBLmvpfAYMwbw0G9XQqqULMbUBO?=
 =?us-ascii?Q?mp2F2ODM/HBqTquQpYomBfutzf5UlbzViKB7O2kId9JWnAzo4q9OSmuGGJ2r?=
 =?us-ascii?Q?voj2FBmjCYEc/YJNNfdBG67Jjk9UDj8i4v+jxYw7saU3QlaXOlY97WrTJoJe?=
 =?us-ascii?Q?23UCw/bsgsJaDvwnTk9HNJv5akEwIvrJYo4S6vBdZqNG2B7CHpC9sB31Unyz?=
 =?us-ascii?Q?uRfpxvekAie3/dCC+aRTuIHgXuJrFLbwZfaQU76doDhoVad1PPtKLLaRzsMw?=
 =?us-ascii?Q?V3RIciSow1m+kNCZ15OQlF1jjchSw/n/ynWMdXxuLkWPjYcHviXgOckX8DqA?=
 =?us-ascii?Q?eGti0SxPmCXjDpgt3QZUlLorzbJ/98HsMGUn8/84s3qaopUqiOjtgCa1+BqT?=
 =?us-ascii?Q?JVrucuaB58VT6ShsoFKiRr2v5JwQknOLKRwd0+YjZURPawHJQtWDy+xoqrE3?=
 =?us-ascii?Q?9PXkVZoGbtIxZPojJqMmfg0MpfKP09w3fZPW//eacslMpyVmgMNz0yY5ktvm?=
 =?us-ascii?Q?nwFbNxeLnJPlByOrnX18RxGFLGz5Aq8ryfhBqXc2sE/eFfxSfNsa9qnOaei+?=
 =?us-ascii?Q?o4hxIqmpWBvjCUJbHYMUlv++N+9/dhQbgaMYEgbR5a2AMBzR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235cc6bf-2ebb-461f-993a-08de9eb76985
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:32:52.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V3HIcqya95f8/cFIgFQKuu+rWvp26/aybdx9cC0g5dwGUEWiID/MOzxmzt2184Twc6DfBAw2pIxQcxSkiC5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12106
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10043-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 1EC534283B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:22AM -0500, Nathan Lynch wrote:
> Introduce a library for managing SDXI descriptor ring state. It
> encapsulates determining the next free space in the ring to deposit
> descriptors and performing the update of the write index correctly, as
> well as iterating over slices (reservations) of the ring without
> dealing directly with ring offsets/indexes.
>
> The central abstraction is sdxi_ring_state, which maintains the write
> index and a wait queue. An internal spin lock serializes checks for
> space in the ring and updates to the write index.
>
> Reservations (sdxi_ring_resv) are intended to be short-lived on-stack
> objects representing slices of the ring for callers to populate with
> descriptors. Both blocking and non-blocking reservation APIs are
> provided.
>
> Descriptor access within a reservation is provided via
> sdxi_ring_resv_next() and sdxi_ring_resv_foreach().
>
> Completion handlers must call sdxi_ring_wake_up() when descriptors
> have been consumed so that blocked reservations can proceed.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/Makefile |   3 +-
>  drivers/dma/sdxi/ring.c   | 158 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/ring.h   |  84 ++++++++++++++++++++++++
>  3 files changed, 244 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index 2178f274831c..23536a1defc3 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_SDXI) += sdxi.o
>
>  sdxi-objs += \
>  	context.o     \
> -	device.o
> +	device.o      \
> +	ring.o
>
>  sdxi-$(CONFIG_PCI_MSI) += pci.o
> diff --git a/drivers/dma/sdxi/ring.c b/drivers/dma/sdxi/ring.c
> new file mode 100644
> index 000000000000..d51b9e708a4f
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI descriptor ring state management. Handles advancing the write
> + * index correctly and supplies "reservations" i.e. slices of the ring
> + * to be filled with descriptors.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +#include <kunit/visibility.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/lockdep.h>
> +#include <linux/range.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <asm/barrier.h>
> +#include <asm/byteorder.h>
> +#include <asm/div64.h>
> +#include <asm/rwonce.h>
> +
> +#include "ring.h"
> +#include "hw.h"
> +
> +/*
> + * Initialize ring management state. Caller is responsible for
> + * allocating, mapping, and initializing the actual control structures
> + * shared with hardware: the indexes and ring array.
> + */
> +void sdxi_ring_state_init(struct sdxi_ring_state *rs, const __le64 *read_index,
> +			  __le64 *write_index, u32 entries,
> +			  struct sdxi_desc descs[static SZ_1K])
> +{
> +	WARN_ON_ONCE(!read_index);
> +	WARN_ON_ONCE(!write_index);
> +	/*
> +	 * See SDXI 1.0 Table 3-1 Memory Structure Summary. Minimum
> +	 * descriptor ring size in bytes is 64KB; thus 1024 64-byte
> +	 * entries.
> +	 */
> +	WARN_ON_ONCE(entries < SZ_1K);
> +
> +	*rs = (typeof(*rs)) {
> +		.write_index = le64_to_cpu(*write_index),
> +		.write_index_ptr = write_index,
> +		.read_index_ptr = read_index,
> +		.entries = entries,
> +		.entry = descs,
> +	};
> +	spin_lock_init(&rs->lock);
> +	init_waitqueue_head(&rs->wqh);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_ring_state_init);
> +
> +static u64 sdxi_ring_state_load_ridx(struct sdxi_ring_state *rs)
> +{
> +	lockdep_assert_held(&rs->lock);
> +	return le64_to_cpu(READ_ONCE(*rs->read_index_ptr));
> +}
> +
> +static void sdxi_ring_state_store_widx(struct sdxi_ring_state *rs, u64 new_widx)
> +{
> +	lockdep_assert_held(&rs->lock);
> +	*rs->write_index_ptr = cpu_to_le64(rs->write_index = new_widx);

Does it need WRITE_ONCE() ? you load_ridx() use READ_ONCE. I just not sure

suppose doorbell will drain write buffer, most likely it is okay without
WRITE_ONCE()

Frank
>

