Return-Path: <dmaengine+bounces-6545-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AD5B5A0EF
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 21:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315381C019BA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731592D73B9;
	Tue, 16 Sep 2025 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ha2EurB7"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5B2D6E67;
	Tue, 16 Sep 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049579; cv=fail; b=aoVmDuAQIOKA3EQhw7BAXB73kuT4MXHB7ch6anm7uZBJGrH+tH7m2CFweRmiGop04cdxue5ARzwZMYFVTMeU2QhOE4OqAFCaPcU+4Vgz4Tc46oqc9OvJUQwb9gceEcIie/cYnXxxHan9y6TvzO79z0KBYUt5uO5qtBwW548IEDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049579; c=relaxed/simple;
	bh=yB2ObhiqQP0tDoANRN6oZBCJFCyhJhOIkNluxKkVxtE=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k2MtHfty87/B6EPf1vPd/zW4bPzvvUMhLc416hFebzLig0L9t9OMEMXBa/dxrkBjhDo/t7fwUZ3knFVkrHuvpj9QIUgkoc7sNwpPKDEcE03vlRWdvt3Rlp5hX+Mapk1VXSz2TLP5c4A6YuBNo6N8AMafDqIMCdQRmOdpY9utrUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ha2EurB7; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RplW6b6Uej3N1oaO4wWCPU011JViNzBOBxxwVAVUKEIwyN72LEuK3/d+qtryuN4HA+EMAVSWIYZNPfcDiwK585L7emSqy7JCQMj315GuB2YVWJJl2UPJvkYp7MJ2irCTO7AVnajltaTurdYXhsNgMux53fzCLJKpd9zYYfY1/9JUwdL5oj4irFHd5Cd/C3C35Gq8zqPmwWLWe4qpwnwwosQIhbZBJMATeW0X32e9fL1/werClRefHMkKfihiCS1aUMox6ZDFZDtzVwTOP7khgWnK/5zEejksCE7Fqr3gZbYIq8qxmj4MqEEqYaB1f4aKgyKhCHGhKVF9m7vpdHn4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYkKNBMfPpeHtwnpCXc9jthy75wODUY2MubXFFqfskU=;
 b=TSqCpVR5gSw/FWaR9cjlcHVIaU+VOxZ3VgR3zRFgdTt6yDf0YJoHqEQaXcivfg6sAMOaAJNhMgSB4oiUlK41RkIYRcNeYHQUrYFJymtIqI4Z0XDn74/0m5MNRrUOurDmRtugaGR7Iatt5bmAEmMHNt0kf4VgraG8S1FWWPRF6VeT4ZiS680nNCZCCb/dptDP+3uj/GtnLF/Jo30RRckJz+YiabK8teZgfAjEezJQNsl1dHO/f4kgYS8Ha1rSxVRT3nkmoDSTEuSOsP5iJQx+K2mfSJcwkBVuVtbhWItCkwxESg9bnV1jeTwfuVXXuFuoWFaQ09Quc3KAYatjKominw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYkKNBMfPpeHtwnpCXc9jthy75wODUY2MubXFFqfskU=;
 b=Ha2EurB7iy8qo85jzi4MZijo/QvMe8yterp1sfVdR1YdHOdkTHHYqSP6DOt6nW0avcsw501IABhz3igMD1WW5u6ZlM/unE3s8jPXEDj/3B5LICkpahUQkQ7oKdKmV6IG2wPf1EYftcJcOrb3DFWI/S3WNHbC7kHyPi6fH/EbKYI=
Received: from SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 19:06:12 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::d9) by SJ0PR05CA0164.outlook.office365.com
 (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Tue,
 16 Sep 2025 19:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:06:12 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:06:07 -0700
From: Nathan Lynch <nathan.lynch@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>, Kees Cook
	<kees@kernel.org>
Subject: Re: [PATCH RFC 03/13] dmaengine: sdxi: Add descriptor encoding and
 unit tests
In-Reply-To: <20250916152057.00005f7a@huawei.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-3-d0341a1292ba@amd.com>
 <20250915125226.000043c1@huawei.com> <87ms6va4z4.fsf@AUSNATLYNCH.amd.com>
 <20250916152057.00005f7a@huawei.com>
Date: Tue, 16 Sep 2025 14:06:06 -0500
Message-ID: <87frcmxlnl.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f26c7ac-5970-458d-da1c-08ddf5541a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q9ahvECdflB/tDeS9JLp+PdWFgvLzunIRNj4dtacoOiAijhnLh1TEli/r1mg?=
 =?us-ascii?Q?iAhaIkOo2u9G12d+TIyqSUqY3IIEJLMmsDKwfzruozREE+WR/L2ZOJJ9Kvq/?=
 =?us-ascii?Q?sLOOlVmob3GstnjLrFa8onu4rZ5CbF9+s+thiLq7bZjgiyzv6m6KEYIgN7Zh?=
 =?us-ascii?Q?dV2gQEKookQm9HaBFkfVSCRwzW04PLDmFXbf+Zj3E37j3zHyhm8GL8oalz5N?=
 =?us-ascii?Q?MXu1EpmnsE55dRwvPrDg5pwvbp8mKJVb6zHFHaTSZ8g39ryWQ84SPPGeB+uR?=
 =?us-ascii?Q?cGQAIxHJw4+uTYtFG7rpJoXponddgJqUVs4RETz62HINX3vWPWRqSmjHDYYP?=
 =?us-ascii?Q?2h/khqCBpWxoQ4QHo7bqbVrcNFmMKeBWnJh2rS2NqGqObKvzYUbox+o3Hv7p?=
 =?us-ascii?Q?z6Vk75Z4tpOjldplMZ8WQ0DYoVqWA8R4tKt9/Y4/A8CqFNRV9r4ceV1Lk7O1?=
 =?us-ascii?Q?Lwb8xZUF7Q4yzz0OrGuiK+TuyNr/DNPta5BIE8PRZUqr+ZJjO2/q7AM7ddRU?=
 =?us-ascii?Q?eQfxTECPPnbaZOVEzJk+c1pU1Tm098HsxfynLLxCoPoJ6ZZrgmNHb3wYfGA2?=
 =?us-ascii?Q?vbKw+thGsF/XX0oBM65N0RDo+eg/lHfzujB+lu2wvtS7U3+q1JHQCUE9+y8z?=
 =?us-ascii?Q?r8hV7JQXRFHN1jVdPmyn1rXw6iF1KMfoJn09jao5HJva6E6Fv4ClRw0rrpfS?=
 =?us-ascii?Q?FUZvRJcyMjMiAJ581abEVf34ZowYPpwsDJQMT2sdldTuKKDyeJKA8Z9hAd9b?=
 =?us-ascii?Q?Fi6UAGrdB14lO6oO/ZuJasMks2Fb3csbZa60OD32bqAY6xqpM6X3xDTOrWqT?=
 =?us-ascii?Q?LgASxMiApR1hivAsQNKRS63FR3AADafYyhzD9bTnvpyeFZGub5zj1IKDSuEE?=
 =?us-ascii?Q?RBfdVDhVJwavNCkY5+4Apm96Y0iQwqy6TZ5/34NMrzvv8YOfJ3aQRoY//dLP?=
 =?us-ascii?Q?3cPFaHFKZHs9Sy4TV/gfaPzpteTIQt0f+FF4+3/Z5q9m9o4SpRZ1T68M5AFq?=
 =?us-ascii?Q?hqsKok5XtWk+h3XwFV3oy6QR7kJyPyAM5VqcsIGNE1l3BpZmtI9ksEchOKig?=
 =?us-ascii?Q?dFCqm+F17LJw6B+GrIQi7lDV1jTVlLXDBXkPIII78nZ+2JZ0wTlE5WL3uENs?=
 =?us-ascii?Q?DTJkBdAZZIWHvn0Fr5UJP496bkORK968dRBo1mnXASQY9iGXyjjNY1dbx4Yh?=
 =?us-ascii?Q?fq0FtsWKtkZ8fLgjZHZR2U7WyD0V4izhlLuxTO2egPDel6dShREmwxee5zgD?=
 =?us-ascii?Q?JUDpKoXaoAEVj4VPaovO/le1Xo+6VGhaMhT+W1BnOtaKvn2I/u9b6IXtslJl?=
 =?us-ascii?Q?A38gEpdqeWJaotqGjyR+KvMTryqIJ2qQFntjEALmQVKYe6KyFlG4T3H3PFIg?=
 =?us-ascii?Q?BhHT5KRcc5MY6vppIhvgegN12Ooemv8WcrT+9bInvEQ7WwSVMvwagLpGlwPw?=
 =?us-ascii?Q?d/rbcuaCcRXBtM0BrDPpUryfWovjkPjEdkfDb67bz45DuBeluXKj6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:06:12.3027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f26c7ac-5970-458d-da1c-08ddf5541a55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144

Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> On Mon, 15 Sep 2025 14:30:23 -0500
> Nathan Lynch <nathan.lynch@amd.com> wrote:
>
> +CC Kees given I refer to a prior discussion Kees helped out with
> and this is a different related case.
>
>> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
>> > On Fri, 05 Sep 2025 13:48:26 -0500
>> > Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:  
>> >> +++ b/drivers/dma/sdxi/descriptor.c  
>> >  
>> >> +enum {
>> >> +	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
>> >> +};
>> >> +
>> >> +#define sdxi_desc_field(_high, _low, _member) \
>> >> +	PACKED_FIELD(_high, _low, struct sdxi_desc_unpacked, _member)
>> >> +#define sdxi_desc_flag(_bit, _member) \
>> >> +	sdxi_desc_field(_bit, _bit, _member)
>> >> +
>> >> +static const struct packed_field_u16 common_descriptor_fields[] = {
>> >> +	sdxi_desc_flag(0, vl),
>> >> +	sdxi_desc_flag(1, se),
>> >> +	sdxi_desc_flag(2, fe),
>> >> +	sdxi_desc_flag(3, ch),
>> >> +	sdxi_desc_flag(4, csr),
>> >> +	sdxi_desc_flag(5, rb),
>> >> +	sdxi_desc_field(15, 8, subtype),
>> >> +	sdxi_desc_field(26, 16, type),
>> >> +	sdxi_desc_flag(448, np),
>> >> +	sdxi_desc_field(511, 453, csb_ptr),  
>> >
>> > I'm not immediately seeing the advantage of dealing with unpacking in here
>> > when patch 2 introduced a bunch of field defines that can be used directly
>> > in the tests.  
>> 
>> My idea is to use the bitfield macros (GENMASK etc) for the real code
>> that encodes descriptors while using the packing API in the tests for
>> those functions.
>> 
>> By limiting what's shared between the real code and the tests I get more
>> confidence in both. If both the driver code and the tests rely on the
>> bitfield macros, and then upon adding a new descriptor field I
>> mistranslate the bit numbering from the spec, that error is more likely
>> to propagate to the tests undetected than if the test code relies on a
>> separate mechanism for decoding descriptors.
>
> That's a fair reason.  Perhaps add a comment just above the first
> instance of this or top of file to express that?

OK. Looks like sdxi_desc_unpack() and the related field description
structure could be moved to the test code too.


>> I find the packing API quite convenient to use for the SDXI descriptor
>> tests since the spec defines the fields in terms of bit offsets that can
>> be directly copied to a packed_field_ array.
>> 
>> 
>> >> +};
>
>> >> +	u64 csb_ptr;
>> >> +	u32 opcode;
>> >> +
>> >> +	opcode = (FIELD_PREP(SDXI_DSC_VL, 1) |
>> >> +		  FIELD_PREP(SDXI_DSC_FE, 1) |
>> >> +		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_STOP) |
>> >> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
>> >> +
>> >> +	cxt_start = params->range.cxt_start;
>> >> +	cxt_end = params->range.cxt_end;
>> >> +
>> >> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
>> >> +
>> >> +	desc_clear(desc);  
>> >
>> > Not particularly important, but I'd be tempted to combine these with
>> >
>> > 	*desc = (struct sdxi_desc) {
>> > 		.ctx_stop = {
>> > 			.opcode = cpu_to_le32(opcode),
>> > 			.cxt_start = cpu_to_le16(cxt_start),
>> > 			.cxt_end = cpu_to_le16(cxt_end),
>> > 			.csb_ptr = cpu_to_le64(csb_ptr),
>> > 		},
>> > 	};
>> >
>> > To me that more clearly shows what is set and that the
>> > rest is zeroed.  
>> 
>> Maybe I prefer your version too. Just mentioning in case it's not clear:
>> cxt_stop is a union member with the same size as the enclosing struct
>> sdxi_desc. Each member of struct sdxi_desc's interior anonymous union is
>> intended to completely overlay the entire object.
>> 
>> The reason for the preceding desc_clear() is that the designated
>> initializer construct does not necessarily zero padding bytes in the
>> object. Now, there *shouldn't* be any padding bytes in SDXI descriptors
>> as I've defined them, so I'm hoping the redundant stores are discarded
>> in the generated code. But I haven't checked this.
>
> So, this one is 'fun' (and I can hopefully find the references)
> The C spec has had some updates that might cover this though
> I'm not sure and too lazy to figure it out today.  Anyhow,
> that doesn't help anyway as we care about older compilers.
>
> So we cheat and just check the compiler does fill them ;)
>
> Via a reply Kees sent on a discussion of the somewhat related {}
> https://lore.kernel.org/linux-iio/202505090942.48EBF01B@keescook/
>
> https://elixir.bootlin.com/linux/v6.17-rc6/source/lib/tests/stackinit_kunit.c
>
> I think the relevant one is __dynamic_all which is used with various hole sizes
> and with both bare structures and unions.
>
> +CC Kees who might have time to shout if I have this particular case
> wrong ;)

Thanks for the references, when making this decision I consulted:

https://gustedt.wordpress.com/2012/10/24/c11-defects-initialization-of-padding/

and

https://interrupt.memfault.com/blog/c-struct-padding-initialization

But we seem to agree that it's a moot point for this code if I make the
changes discussed below.


>> And it looks like I neglected to mark all the descriptor structs __packed,
>> oops.
>> 
>> I think I can add the __packed to struct sdxi_desc et al, use your
>> suggested initializer, and discard desc_clear().
>
> That would indeed work.
>
>> 
>> 
>> >> +	desc->cxt_stop = (struct sdxi_dsc_cxt_stop) {
>> >> +		.opcode = cpu_to_le32(opcode),
>> >> +		.cxt_start = cpu_to_le16(cxt_start),
>> >> +		.cxt_end = cpu_to_le16(cxt_end),
>> >> +		.csb_ptr = cpu_to_le64(csb_ptr),
>> >> +	};

