Return-Path: <dmaengine+bounces-9612-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDhbO6z0wWmmYQQAu9opvQ
	(envelope-from <dmaengine+bounces-9612-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 03:19:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D5D30114E
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 03:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 093F230465E0
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 02:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD313845AC;
	Tue, 24 Mar 2026 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qJRDnbBz"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020108.outbound.protection.outlook.com [52.101.229.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B402383C93;
	Tue, 24 Mar 2026 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318246; cv=fail; b=JQ1RMVoUaeGllZljV34pXUaIzphT5qi0q9qZ/1SXb5XiuGU0Y4gxZHpP3P0Zuu5mLcoXozHWr4NgqBHy21ICTjUp0me8Fi6OeA6a/2UKAFds3lVn6dKhYGc584ioR8f3Lw47Lb5k1+24mUoh+ytf7D5UcqtQiIyjR6thC9VbMok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318246; c=relaxed/simple;
	bh=gup6Fr+4WF6q8s1I/XVNqbuF6u2IutnuofbZdpJqwFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QCEkrDnOcmQTOjiTAaa+bIbJXVICjFTy52ITLZynGg/pnlvEzKqyFscbzRUgwV1E8S3grWHJ2VWKX0QY7CGm91XYyZu91irPt7hObe7JOXdRUK80f6Oql5eSBqDHn1s+U+hS2otxoz0NoDBUrrxMjGHQ++GvTV0FKfKLE0MVB9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qJRDnbBz; arc=fail smtp.client-ip=52.101.229.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldZxZUpBAppxyVZX9L9AC0/Nn2/MoTfbkkrPh1+qEbIYDgFzH0gsFTFgFdGIVwGkTgD6POjxvsjtAy/NA19K1gguCsfi9uLBzRShQdvebVizIN1i+hxx4B1aHYfAK+sbQm9MU1oY6/Dn4Gr6wWsx1TesLTasMrh+K20lYrxj2i56h6Iw9JP7wbWxziEn9z4PZUaQITwhkyPel+IXlkpG9ftmONk/5oZIh6iN89jexvOgASFotnnyCLn45lHSxs95UEqvB5kkVLCCIX2//+3VHCSeWeU003wgzJDx2J366rHJwZrJkbJ4IE6lh42lu7FDXY0V2wLL9dRusbw9lXOZow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMc7hbOgUGYhLinhdoERgRZQo1tlI8L5dophKHM6Zsk=;
 b=ZwJxjbxYwfmyQTxfhX35aGdtg2rFInbryv2GEhOQ+Liv+ex3Pv1XJIHMfrwUb3D0za1CbvUY0SrIlbOmdulMrkZmX3yZg8BxDpVtoPcbq88q7Dr8NcNP7gFC1ey0wwvUID+KKElMU7ODbBEkcGNlNHsSZLHSmn9LP8Pys6pTLeyLzENUldYXb86MSO3v0TkLFoJZ0nN/WZU4sPFJ0BLMGLB4f+CTMWKEpVqOblvmEVWcRY6vT6P9QiNgR62Agyp1fY15DZk5CBGCHJpgyhovLPrW1VD3bHMRfB0BPEcCoPjvVlZdS+GZwCHbHPdbggxIqBJhY243cHc7jWERuuF0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMc7hbOgUGYhLinhdoERgRZQo1tlI8L5dophKHM6Zsk=;
 b=qJRDnbBzGXHT5UIzuetO6f2Xgzlp12if2L4LPYv3pTXJcIegXW20i9P0FyaFHh7cJlEc9vZWa+1/AiMlerJhNjgizgo5g3CDtK9Bki/ifaeXjcRJUfpjMK+JBelF4tHGxo03iVeasAd9AaKmNXcVWTvECFKWtAWLQiR6N8zaFEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4366.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 02:10:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 02:10:39 +0000
Date: Tue, 24 Mar 2026 11:10:38 +0900
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: dw-edma: Add interrupt-emulation hooks
Message-ID: <sx5lh6keh27nxq4vmdr7vj5dzb6v7pl5mbj4yaq6v4mkjo732k@xfrncjywnjz4>
References: <20260215152216.3393561-1-den@valinux.co.jp>
 <20260215152216.3393561-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215152216.3393561-2-den@valinux.co.jp>
X-ClientProxiedBy: TYCPR01CA0098.jpnprd01.prod.outlook.com
 (2603:1096:405:4::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a307615-be24-4375-bd93-08de894a8b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	npQylXM02w5vqFceFUdYQa3A24OWxEAJRQhKQTHzeB737H+gh9iI4eETLZWSUvHHgAxd95ef+ojPqpJzIaY0MCk6A1XIO0LxZxLBn1/qFQX4ENx71Bn37hp0LuZ9flTkEqWm1xWBUR9SuBRrZnBtEc2CIPX2YlqC+KHGX9uPkn2VRpcCEZ/ZohX7+tfkJbiOt3L+JTX8nFjLqY1WqO2Pv8mA4IahsJyw9Jh8arpo+m9SMj+i09r7e8QbAsbNGBZMaBnbfYme+Tqx/kuLMKWers7cxA4ZwGrbXHcf5wrOJp6WcoWQd1gLCgegIFpQxGNLwZS/X0t5aXTSQymdpk0Cg8DYJmdduH5rnVxKC3CL7fMB9gx40w2yESP0Va7V/glkBpWoKWIYa79ZteKQq3L6t5r3qkqJef7d8KJmUN7RfXMj+/27xTvyQxAlTlU4i4L8HMKwe7l0CmpqVzjeShjvr9ZJq9KxgMgXM6H3HChBHqpc+ICi25CmzZY3dFd17SrKVk83BXMRGWVlwOPo6gVjneAZDas2d8z334ltbLOjoLLvVMAjmySrd/SDJ7ttSA4q7bKdGvSW8UByi5czVKIzZ43Jni4mNQ74PrNF/v5S4baKPWH1Yz0hhdcRH6Wx395sMs8JlgrfRC7VKWBGEWpL0SsxlLe2/q7PsFcOXU+a83jBeGdfCbQTPSWh16A3HfvAOXQ7nlovcjrpHPRzefGKIso9YIudE5kDmAPu7/n4HvY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vB8xPOmxzZacmeotipCR1FJ+9jcD5tKpcCOsMlNIivTkdyFOPtQbdaXgVOaU?=
 =?us-ascii?Q?ORcwWBER8dxo/bMa86XvbDHvCOszOoIeJK4CfqDKzzw+Tc0T3Pd+Ufib9B4K?=
 =?us-ascii?Q?+n+SsNvHWRRphf+BEkTNTHBYZgMx9ifz5C6Fi3yN+6XBW+8FoopTwe/ZtKZc?=
 =?us-ascii?Q?LNcLHRGETWwRbLJoP/aQA8MBj1/p3wniBFrr67OEuGpsWW2sjCRXxTZdCqLF?=
 =?us-ascii?Q?hf+6gzfBrW5vIV+ocLM0NGfzI0ZBoaDJoiwWCQX+67VxsEVw6qGdEvbjdGun?=
 =?us-ascii?Q?VBZXNeC9EmeP6A8l3QFXvE76WDzuvPu/2DRR+4Qd8ZQC4L45EAbD4ToBWil+?=
 =?us-ascii?Q?yA8tCsjaMQwVYQGdEu8saHKoXnogSzWdZP/Cy5Hq9Ur7ZwyAeSGAK6QfXSq/?=
 =?us-ascii?Q?lrpmkuQcXpndWYy/Wy/MWm3xSubyUqona4baljr7RrotYqW9PSODAePWesjY?=
 =?us-ascii?Q?nWx16KyrcwC+7DHChHPxbjfqAufJGc1ufYrmvzqdkodPLeNf2jenpHmnn0vZ?=
 =?us-ascii?Q?Xq1IJnz9nM0PyJLloUAWoN/kC/8uFdtalB0w19hLGZUsbbvP2zp+HAAek8oq?=
 =?us-ascii?Q?vg2htnr8gpmvlpcVD5jOHpag2l1uBJSDmqMoU//nLtv4s3b6GSWEYABpJsyw?=
 =?us-ascii?Q?jPqx0U5uU7d2K6q/3gLBKN+WumWalhszmbotwxbVRV/CbGDu3XIn4uvb6dzS?=
 =?us-ascii?Q?0DXeEjjfomVxULwtfPz6GQ2zrVegHpdsn036ZQ2PvD86qzoSJnNwEBm9oK4r?=
 =?us-ascii?Q?2WRGrFYCpsUW/nafp/4oV7Tia53YbaIILOEfSAZuOovI3h/6BeNrsLgiblaf?=
 =?us-ascii?Q?KkX+jT+RHRyJYgSpSbBBQEMOcEO0XLmN9PrLdBBJJmzWZXkTdWPVyk8O4x5a?=
 =?us-ascii?Q?Tu4ubSF/28HFOXFNyn+9Md1N7tP5aRLVYlcmPTLPwXNPAULD9lwQgxa/VSaZ?=
 =?us-ascii?Q?or6N37eoes8P6UeCIfhz5MJrfonod2dXI1Cn6DibCt6J/RJ8OV6z9OhLXPwn?=
 =?us-ascii?Q?3cI3zR7vHBeowwfyN52YcFsJLL0NocRNv+d259JQqn2rT0L7L/yIqC8rkmg2?=
 =?us-ascii?Q?c63N8N0tuKPVTdS5SLewiWpUpAplrV2ZYwZu8ZRZGxw9mT2xUPag2Zn+6hzH?=
 =?us-ascii?Q?43lWupaNzIId3852aGTfof56kvG7VisLu1Ouv4hpcXzvt7HyChnHauq+320o?=
 =?us-ascii?Q?mCxksn8LGjskWEAI+A+shnSzmxsWZJFvYCpHlTySFC25a6dy0vsVurR2i4Ob?=
 =?us-ascii?Q?U/Fz4GZzPGJ8HI1z8QkPo6dU12BuNpnBjT3yt5WFNz9TWZCEyUZ6O7M98lFN?=
 =?us-ascii?Q?7zbeE8+hgLyEOGSc7j6SIYGq9OKTF7d4fyDLCI4OTii6wbhreWZRT8vxq6Wt?=
 =?us-ascii?Q?Bp/QbjNW9vEjvJ7y9QFZPuRagzhuEMPBOVZNSRVszD7rHHHO+gpJM/L0Y8xe?=
 =?us-ascii?Q?BTlNvDU+eGxXV3Tofyu5rUc9xtTpCE60txtFmXQP5WQmM8nBo5sV/UcMRe8k?=
 =?us-ascii?Q?/mwFpkkWJTXpBswIfkBnZYWEXmEekUwMWTht7nK36UD86J5nXdfp76R5LHN9?=
 =?us-ascii?Q?T5riQV1xbjmFSP7xb5WfhWf7PLoy00yvpAuSWFXEN++oHFw26EjhZ6dn6UFE?=
 =?us-ascii?Q?bkDmLn5sXRCKy2TItO5vXHjU53dcFGmJuXpy4bZ1JF3C2zakd/t0SjJN9NFJ?=
 =?us-ascii?Q?nbRwakb58xaOFH42ZPBIpzTAkxftt4p34uWLDOd/qk3RYWpYe8KPKzddbVSc?=
 =?us-ascii?Q?+3SrznY3mvO5NOIe4BSjzfZ4BIZX1i3qtGb3TIiKVG/RBzyXkNqt?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a307615-be24-4375-bd93-08de894a8b97
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 02:10:39.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjBbS4H1Fylr0dQ/H8dWfCXauZM9khJkW1N2LKausaXhbCFVoLEqEMkPfhDpaf5AZIYKbGGtl2HaTOb+TxynHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4366
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9612-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim,valinux.co.jp:email]
X-Rspamd-Queue-Id: 57D5D30114E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Feb 16, 2026 at 12:22:15AM +0900, Koichiro Den wrote:
> DesignWare eDMA instances support "interrupt emulation", where a
> software write can assert the IRQ line without setting the normal
> DONE/ABORT status bits.
> 
> Introduce core callbacks needed to support this feature:
> 
>   - .ack_emulated_irq(): core-specific sequence to deassert an emulated
>     IRQ
>   - .db_offset(): offset from the DMA register base that is suitable as a
>     host-writable doorbell target for interrupt emulation
> 
> Implement both hooks for the v0 register map. For dw-hdma-v0, provide a
> stub .db_offset() returning ~0 until the correct offset is known.
> 
> The next patch wires these hooks into the dw-edma IRQ path and exports
> the doorbell resources to platform users.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.h    | 17 +++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 21 +++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c |  7 +++++++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 71894b9e0b15..59b24973fa7d 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -126,6 +126,8 @@ struct dw_edma_core_ops {
>  	void (*start)(struct dw_edma_chunk *chunk, bool first);
>  	void (*ch_config)(struct dw_edma_chan *chan);
>  	void (*debugfs_on)(struct dw_edma *dw);
> +	void (*ack_emulated_irq)(struct dw_edma *dw);
> +	resource_size_t (*db_offset)(struct dw_edma *dw);
>  };
>  
>  struct dw_edma_sg {
> @@ -206,4 +208,19 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
>  	dw->core->debugfs_on(dw);
>  }
>  
> +static inline int dw_edma_core_ack_emulated_irq(struct dw_edma *dw)
> +{
> +	if (!dw->core->ack_emulated_irq)
> +		return -EOPNOTSUPP;
> +
> +	dw->core->ack_emulated_irq(dw);
> +	return 0;
> +}
> +
> +static inline resource_size_t
> +dw_edma_core_db_offset(struct dw_edma *dw)
> +{
> +	return dw->core->db_offset(dw);
> +}
> +
>  #endif /* _DW_EDMA_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b75fdaffad9a..69e8279adec8 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -509,6 +509,25 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
>  	dw_edma_v0_debugfs_on(dw);
>  }
>  
> +static void dw_edma_v0_core_ack_emulated_irq(struct dw_edma *dw)
> +{
> +	/*
> +	 * Interrupt emulation may assert the IRQ without setting
> +	 * DONE/ABORT status bits. A zero write to INT_CLEAR deasserts the
> +	 * emulated IRQ, while being a no-op for real interrupts.
> +	 */
> +	SET_BOTH_32(dw, int_clear, 0);
> +}
> +
> +static resource_size_t dw_edma_v0_core_db_offset(struct dw_edma *dw)
> +{
> +	/*
> +	 * rd_int_status is chosen arbitrarily, but wr_int_status would be
> +	 * equally suitable.
> +	 */
> +	return offsetof(struct dw_edma_v0_regs, rd_int_status);
> +}
> +
>  static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.off = dw_edma_v0_core_off,
>  	.ch_count = dw_edma_v0_core_ch_count,
> @@ -517,6 +536,8 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.start = dw_edma_v0_core_start,
>  	.ch_config = dw_edma_v0_core_ch_config,
>  	.debugfs_on = dw_edma_v0_core_debugfs_on,
> +	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
> +	.db_offset = dw_edma_v0_core_db_offset,
>  };
>  
>  void dw_edma_v0_core_register(struct dw_edma *dw)
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index e3f8db4fe909..1ae8e44f0a67 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -283,6 +283,12 @@ static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
>  	dw_hdma_v0_debugfs_on(dw);
>  }
>  
> +static resource_size_t dw_hdma_v0_core_db_offset(struct dw_edma *dw)
> +{
> +	/* Implement once the correct offset is known. */
> +	return ~0;

I now have access to an HDMA-capable device (not set up yet though) and the
databook. According to the PCIe DM Controller databook (6.10a-lca06/6.14a-lca02,
section 7.4.4 "HDMA Debug"):

  > Test Interrupt
  > HDMA does not support this legacy DMA feature in this release.

It's unclear whether this holds true for all revisions, but assuming so, perhaps
the comment above should be updated for clarity.

Best regards,
Koichiro

> +}
> +
>  static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.off = dw_hdma_v0_core_off,
>  	.ch_count = dw_hdma_v0_core_ch_count,
> @@ -291,6 +297,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.start = dw_hdma_v0_core_start,
>  	.ch_config = dw_hdma_v0_core_ch_config,
>  	.debugfs_on = dw_hdma_v0_core_debugfs_on,
> +	.db_offset = dw_hdma_v0_core_db_offset,
>  };
>  
>  void dw_hdma_v0_core_register(struct dw_edma *dw)
> -- 
> 2.51.0
> 

