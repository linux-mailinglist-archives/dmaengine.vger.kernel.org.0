Return-Path: <dmaengine+bounces-10971-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPEJBk01FmrrjAcAu9opvQ
	(envelope-from <dmaengine+bounces-10971-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 02:05:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A25DDD8F
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 02:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BED8D3000B96
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 00:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFD523F431;
	Wed, 27 May 2026 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ly9tzn8G"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770D23535E;
	Wed, 27 May 2026 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840316; cv=fail; b=NCONu8wiF1ypZ2dF5Hf4aicA7qLxKH2QjL/wzcPc4pt7RC6H3auc6x6d8GpnsYV5Ni7P/dTevHJxKNUDQewJ2x0ydE43+ogY1UDQBiqxVHJnYvkUJDqHeZolwPhdv/wlQ8rn5mm1CEQi1r6/Jo7Nb0jvpjswFo+PVY3U78RJVqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840316; c=relaxed/simple;
	bh=rSNXUcFK0X+3qdIo0R5ZP7ozvcuPqQyy1X702x2lh0k=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hx4UFj5v2vNuDXPuIwDgb+LsC0MFRCq3/a6RV+evQ73YyO/vHR73Dq2NIY13M1hQAVNP3f1RbZrDghzwq5rha/uvq3DWhLqAZJuyt6z6YQCRZ/a+HfG8lH3UufdCh1YF6FDtiBvQ/cNS5b8GMExU6r/sg6/gA0sqkJyyIO1JQ/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ly9tzn8G; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfbCr5ll7N83KdxY33JOx/es8F66ISAJ3FHisX79l1qDBkEHIamFRglC7HaI33uJMuP2X2Vgdu+UDY+nrFIcquhykNhTI0N8SPTOhZKw4jbkEGRhCzn3UQzk3uOaQg4TsrC8XYv3i04Q2/Zmc1G2TwX6d0J87/XlrRyf7MfyU3ZnqGSmWH6c5vJsx4xvqv9I6x7dorBpkJNxh6uJu7ZwD+BoFW0hd3hP1hxLDcc44cgogEjgze4c0jDlQnbc6Sb6QFmgTm+ZZI04gL8IFsm4vHu4fwry7Eiyhc8ve8ZdvSiUZDKoSMMUtg7Ks2XLCkEBs2leFECZCT28BDhtEtG4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGWQW7UmTTZ0TIXAc26c7qJRQj0cIFmKmkE0X2jQWVI=;
 b=VOLPwhEDoMD9GySo3Crrylkm3QuWLyH/DbAJWE6d8TLXfcbhTnkl8zYEmy/M4/H/jtztDbiFJNyaEz9zBLEDoE6wl3ri1jx0zPIOp3yebRYcblbfECc5D935p1IfSXCMcG5UHph1jqlx7ta/vZIZeXfmgICVS7q/aR+Z4NjBuQq92F2Nq95t6+dvlRAPLjutqQYzca8O8MP7xOZeM55O8e6CrcE2NpbFiy3/P7vGwDc2Xaco01P7nRbQ8ThEzN8pkUZ/2bNNKG4xUvfDrqruBmL5CpTSVXwaCWOsrWdMXXhDhFcZiYOCuTdWdZYSBqfM9QWIfbfrhCHJDCO/fu/ZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGWQW7UmTTZ0TIXAc26c7qJRQj0cIFmKmkE0X2jQWVI=;
 b=ly9tzn8GrB+3cc+TuWqUYC/wVXpFKtU2rZz/kdwHMFKxP+/5ZeKt0WF9e1C1miEnA3tG8X1I3OtIkfn65vYibMraBWgkt0aGNqNYShiCj4fs29Oy9A9B8gew5ONBA15N97yJljrAFW7vc0iaZQG9s4903RIopDjRd0AQd0sY/Nc=
Received: from CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::29)
 by SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 00:05:01 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::a6) by CH0P220CA0014.outlook.office365.com
 (2603:10b6:610:ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 00:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 00:05:01 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 19:05:00 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: <sashiko-reviews@lists.linux.dev>, Nathan Lynch via B4 Relay
	<devnull+nathan.lynch.amd.com@kernel.org>
CC: <Frank.Li@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vkoul@kernel.org>
Subject: Re: [PATCH v2 06/23] dmaengine: sdxi: Allocate DMA pools
In-Reply-To: <20260513013053.5F1E1C2BCB0@smtp.kernel.org>
References: <20260511-sdxi-base-v2-6-889cfed17e3f@amd.com>
 <20260513013053.5F1E1C2BCB0@smtp.kernel.org>
Date: Tue, 26 May 2026 19:05:00 -0500
Message-ID: <877bop90pf.fsf@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: fe67452d-f58d-407e-b054-08debb8398d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|13003099007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ML7GpS5xhlSrIaLcDA+ck4QoeDLepueg2qgDL+42VTaI9sLT5pQTrqcZWtuJfCkXy0f8bMKHMPdqv8M1CZ4+wCjO+J679OAzcKVmAAlgWNgto57lIxlPX4Yp/YbDlgguQgnHzNGEyg/HH4xdr9mkJtMq8+te5Ry0qkv3UJcl54x9AsUwMffQGX9/icnbK8OppddWxj/PIjl+4RQZ8OXcS8PGiijj6b57+k3F1i1N4NUNJNEs2WuWe+AZNT89XMSpClwxwcWCuWYsOhG8H30I/LQGqdUAq7Knr/d4XMiAW7rbRL049g+XHc9TQV1T35v1kdULA5eyjTwiExuQ7lCmrxtJpogVxq6603Bw9pvcoLTqh2hpYPMUub1C8pBTz3bdUCP1R8uMHDaubIxDhfOBANDy4PEXAiyZvg8ISkDrCmr5gDC9+M0BATDHogYW2fOCR6o/CCE6XTIacwEgNbnxXTwK+XW1OT64B/SHthekFfkB3ma1n3svvDjCrmACWYx/VNPxbreK5OcQwl1zWDtjcGBIWTSjz06rYlw5A2YmOn9j40h+bF837w817RU8EpLjXSxNVG/IcJPFrB/9HHnMmuXgpY3bSagyG+IItfv7puktRIeayzh4wiDIOX4oPID7+r2Pa3SlWnemHkIHUFtLTs5jZWij7WhQF/+r1nqMrAA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	knMBiANqy3r0pVqxWbh34kmdHzuzn4SmkIaYABKOUaksVPGNVNTkuhEA//Mc3qiujKLHembfLpztcV0UtfwMQxVwxT6ZLc7gpbwGkOiQGOuCRfoJcWKBjSRGBNhAbLZO7eYfqejK/0XPtEa+4ypGewGd/XYaN/7W28LUfbRHTr4OJZWqGCkO+knufSsYOEMSACeR6sdgbxQxbGhHl5L9IfaiKp+hohE6w6MJvUEFg6SVS8cCVh2Z4SmLXivzFh5EEFCucD80DBT7wJUUAKkObrK9F2m+XvpGRqVnVwu7U1E4cR15tu/plDsoc9ar6TCcBspMPgRc3i5wcelRoZQ28GbET+ATcJEAsmBbog3dR8Tzn2FdXPnyoYMNIYXnuQR+SMqnuhJWVglpuAcexnG8kwfjRZnYorZhcELD+jbvgO0fRZ2zBrjX2Y4VIZu6Rz4H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 00:05:01.2180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe67452d-f58d-407e-b054-08debb8398d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10971-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 177A25DDD8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sashiko-bot@kernel.org writes:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Unnecessary use of `__packed` attribute on naturally aligned DMA=
 structures reduces their assumed alignment to 1 byte, risking torn reads/w=
rites.
> - [Medium] `cxt_ctl_pool` has a hardcoded alignment of 64 bytes instead o=
f `max(size, SMP_CACHE_BYTES)`, leading to potential cacheline sharing.
> --
>
> commit 12aa7b8ec291c34d27a87b91722b70b67d211aa3
> Author: Nathan Lynch <nathan.lynch@amd.com>
>
> dmaengine: sdxi: Allocate DMA pools
>
> This commit introduces C structures for SDXI context control, context sta=
tus,
> and completion status blocks. It also creates a DMA pool for each of these
> objects as well as write indexes, aiming to align them to avoid cacheline
> sharing.
>
>> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
>> index 6a2204ff7fdee..851e73597c22b 100644
>> --- a/drivers/dma/sdxi/device.c
>> +++ b/drivers/dma/sdxi/device.c
>
> [ ... ]
>
>> @@ -211,6 +214,43 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>>  	return 0;
>>  }
>>=20=20
>> +static int sdxi_device_init(struct sdxi_dev *sdxi)
>> +{
>> +	struct device *dev =3D sdxi->dev;
>> +	size_t size, align;
>> +	int err;
>> +
>> +	size =3D sizeof(__le64);
>> +	align =3D max(size, SMP_CACHE_BYTES);
>> +	sdxi->write_index_pool =3D dmam_pool_create("Write_Index", dev, size,
>> +						  align, 0);
>> +	if (!sdxi->write_index_pool)
>> +		return -ENOMEM;
>> +
>> +	size =3D sizeof(struct sdxi_cxt_sts);
>> +	align =3D max(size, SMP_CACHE_BYTES);
>> +	sdxi->cxt_sts_pool =3D dmam_pool_create("CXT_STS", dev, size, align, 0=
);
>> +	if (!sdxi->cxt_sts_pool)
>> +		return -ENOMEM;
>> +
>> +	size =3D align =3D sizeof(struct sdxi_cxt_ctl);
>> +	sdxi->cxt_ctl_pool =3D dmam_pool_create("CXT_CTL", dev, size, align, 0=
);
>
> The commit message states that frequently-updated objects are aligned to =
avoid
> cacheline sharing. Does hardcoding the alignment to sizeof(struct sdxi_cx=
t_ctl)
> risk cacheline sharing on architectures where SMP_CACHE_BYTES is 128?
>
> Should this use max(size, SMP_CACHE_BYTES) like the other pools?

No, sdxi_cxt_ctl is not one of the control structures we expect to be
frequently updated, but I suppose this could be made more clear in the
commit message or comments.

>
>> +	if (!sdxi->cxt_ctl_pool)
>> +		return -ENOMEM;
>
> [ ... ]
>
>> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
>> index df520ca7792bf..846c671c423f5 100644
>> --- a/drivers/dma/sdxi/hw.h
>> +++ b/drivers/dma/sdxi/hw.h
>
> [ ... ]
>
>> +/* SDXI 1.0 Table 3-4: Context Control (CXT_CTL) */
>> +struct sdxi_cxt_ctl {
>> +	__le64 ds_ring_ptr;
>> +	__le32 ds_ring_sz;
>> +	__u8 rsvd_0[4];
>> +	__le64 cxt_sts_ptr;
>> +	__le64 write_index_ptr;
>> +	__u8 rsvd_1[32];
>> +} __packed;
>
> These structures appear to be naturally aligned and padded properly. Does
> applying the __packed attribute without an explicit __aligned() attribute
> force the compiler to assume 1-byte alignment?
>
> Could this lead to the compiler synthesizing multiple byte-wise or narrow=
er
> memory accesses for 32-bit or 64-bit fields when they are read or written,
> potentially causing torn reads or writes if the hardware lacks native
> unaligned access support?

Valid -- I'll add the aligned attributes throughout (I want to continue
using packed to prevent inadvertent padding).


>> +static_assert(sizeof(struct sdxi_cxt_ctl) =3D=3D 64);
>> +
>> +/* SDXI 1.0 Table 3-5: Context Status (CXT_STS) */
>> +struct sdxi_cxt_sts {
>> +	__u8 state;
>> +	__u8 misc0;
>> +	__u8 rsvd_0[6];
>> +	__le64 read_index;
>> +} __packed;
>> +static_assert(sizeof(struct sdxi_cxt_sts) =3D=3D 16);
>> +
>> +/* SDXI 1.0 Table 6-4: CST_BLK (Completion Status Block) */
>> +struct sdxi_cst_blk {
>> +	__le64 signal;
>> +	__le32 flags;
>> +	__u8 rsvd_0[20];
>> +} __packed;
>> +static_assert(sizeof(struct sdxi_cst_blk) =3D=3D 32);
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-bas=
e-v2-0-889cfed17e3f@amd.com?part=3D6

