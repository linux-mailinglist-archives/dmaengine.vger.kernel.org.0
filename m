Return-Path: <dmaengine+bounces-6521-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA48B5854B
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 21:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FE8207439
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5B2773C3;
	Mon, 15 Sep 2025 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yInj8dJx"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14C1F4613;
	Mon, 15 Sep 2025 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964641; cv=fail; b=CBjrjOI2U2iZU48gOeBXGq6ifst30BfE7WZD11eeX7+EIti/9CGb02E+02usT4Sa2XqlACZiiXGiWQgFX9SQkqMuEEugPyEa2yiPfAnu5KVwZVxJc38Em5L25eaScvCSavHlW7rNRzNGwZ7yLC6rHkR9FMr6KWncsYMJm20ypVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964641; c=relaxed/simple;
	bh=dllN2q98Rp4+aTjI2P/sq8kIAIn1DypSP16kUoH4Q18=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BT55Cy2qwZGSx1368Ieixb4o0mak71CGFa4wER/sZTRylskIMgwawMTmdA3PkAG1ZTs1lSkom6033DWkE9nHGKQEebuspiXqJZnbRIkEQvwFqwzX0RWMdRMBC+JPuMpzX2t6PAcXb+fRwKwmfu37nEIbf3WMJqU6RRxadbgtr/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yInj8dJx; arc=fail smtp.client-ip=40.107.208.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEmPClRbNqeXMkYzC53zgsotmovCMOPUIHlXJBAflOsq6jtYplksAE2PONZYU1hJzMAEDAcn7fxFpp+CS3EuJG7PEVtZPMCf3qoDXHiA7oSvcHizdOMrMeJZlGixAsw+jMxPpkZ1zSmnsBQUQ2quSbmwUCFW+B3oujiguwswpwAxjep6/YFPIkbeagMis0Fz3hZAzyqzbfeJlAhmBbR5NUkFvv+vsZ0nhA5cLNroGjTz+YJgxr+Bi+rZtbCVwv3TnuLrSlvPkICF7uQ4qS4qMytQsxKngLc0lT9qz/W8o0LYpZNfVg55nzYSEBEONqa2f9c5kw6L6mQYmAsSxQ4J9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk2w2BZptxkU2KH54M+OKGBYa5jfIUQetJ5Tojw1LW0=;
 b=JLEcRzQPuz7pKyqbewxxdLkgA8zsKKU0LWevrYJJO79A7jXqMBj2aX6i4F4swc5lJhSl5tFRnq53Rc/NKLREJnw2A7DVI4Z+2Nn3dbPNA/AicaMOmpzl7R97cy6vsCQYk14pSnQMfCJdB0ij7GtGkZ08+AXsL3DCi8HJ3Pn2BTbpIh7PfceAfgO2IG0m5Lk8bFndV0Pl+0CfwLDFhkDplqEd7encLw1zyj3qZQ9ssEHJekVbhtAQg1AekOOQ3/doAbz+1Z08e29XA7X4923l9lBVgXhMZgNX6Pk30NMXyHqO9oQWRx4j1Iuns2hf/CgXE1qLxb/AzIr1H7SIIBrgJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk2w2BZptxkU2KH54M+OKGBYa5jfIUQetJ5Tojw1LW0=;
 b=yInj8dJxiu0XrwqEVcP1m382pYTyuj20Tb/4KuyUr/ss9FnKu6HRVyTxfwcivE7shvYcC9DShFWnIM2ZVVCCvLAZTYPrld9/B+W0p7l9hKrTt9XxcTIDv4OfCG4wzFp2nMOjX3q7tYKWgTxgVeIe0/7DURyaeWmZzzTAM+BZiNo=
Received: from BN0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:e8::19)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 19:30:32 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::50) by BN0PR04CA0044.outlook.office365.com
 (2603:10b6:408:e8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 19:30:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Mon, 15 Sep 2025 19:30:30 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 12:30:30 -0700
From: Nathan Lynch <nathan.lynch@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 03/13] dmaengine: sdxi: Add descriptor encoding and
 unit tests
In-Reply-To: <20250915125226.000043c1@huawei.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-3-d0341a1292ba@amd.com>
 <20250915125226.000043c1@huawei.com>
Date: Mon, 15 Sep 2025 14:30:23 -0500
Message-ID: <87ms6va4z4.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 264c6ae5-a21c-4a50-c211-08ddf48e5521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJhzKtRM41xCdj1A1ObRScNPCdJwrDMbRfvZhJgEcFvC6R42Po5bzwYNDF3u?=
 =?us-ascii?Q?6uQFsFiWMjkswYn86kcZdGw9SzmSY0lo7n2Tcp1Dl8kAs2e95aNjDB3+6iJh?=
 =?us-ascii?Q?PxORsDwd2X+j6cxe3eYdn2Vczcz8bq0YE+vEnD4vhnC2UUsh+FHT4/dGtIEa?=
 =?us-ascii?Q?2+lRDkeX+NHWGyQ3wBEe+cpj59AoE1Ga/uf4b4RL9j0ZPSoMOpc3VToJu2/J?=
 =?us-ascii?Q?D8ok2LHU0xP0mO0lVUzEwIslkrEDM2up1BXvg2pKybidFoP2H1FiRjXfl/nX?=
 =?us-ascii?Q?5+CStb3F/eefKZApy++Sr2R93b60SSUg3TvZmP9NTvDeb0gnBEBFTxGXmsKi?=
 =?us-ascii?Q?wPBeHBg0lEAgtCz0PoSfv6yjYrtZOYZZAUX/HT61AHhgVDyACyLIsHyob9bC?=
 =?us-ascii?Q?j9uEtyNEIStF/F21ZV683l4VVsmoLcRaO/ouN9hfKfceFs+PDVPEAiB95XuZ?=
 =?us-ascii?Q?olzvw5+KfQbtJYQlwH7wU+Rh9sKtgTuwpMTLNHIhfm4xheN3wXP/rW2k8WAk?=
 =?us-ascii?Q?FxOHYSYHXhXKWmpmnOuVEUgZksozOd/W7oabjbL9EBGv6N1xllywoebkanm0?=
 =?us-ascii?Q?XyW91/FlSDsQwxB0t7WsFC54nI4jnu0V0W7U9J5aEIlFun9vcxIbjYxT2s38?=
 =?us-ascii?Q?pUxhJHWqeMXXhz64mW+QFYiZ69IIwbhaFYNdZBzsXYY+DSuOfxkLFJC3f7xy?=
 =?us-ascii?Q?qOViTJtrI2MR3vl3sXiPos4GlzR1QpJhkglrqrkPRYA51vr45fLNOp4LyDzh?=
 =?us-ascii?Q?CCbsQwCFNPROgj3chtHYgffspxCPL7SMMcAA1l0dsNFpL2TKbJsZ8ccwATIx?=
 =?us-ascii?Q?0QT4spsUL/NjqtZoPHHy+pQLwxX/0FI69M+SrYKlz4Dg8TuxcGdkuhL6pfAo?=
 =?us-ascii?Q?CMyWm1YaurIBy+tP4TT276ZLixLvuOuwxThLxZ6unvXaxbiP7kAwyZ7Sxp11?=
 =?us-ascii?Q?t4eQmWKFCc00AhoBorR7j/a29zmJHZgg+6yMsKzVu2DLdGoSM/oUBJ8d5QkI?=
 =?us-ascii?Q?NcQTPOwlLRssaBf08ZO5IiYHIod47OcclfGHNbmZXmpLkHv6eIJlw8gvyMNK?=
 =?us-ascii?Q?QzG1zUyyq++j9yDIDswGTMeRUqIg+g7tlCZiRGEMbvBq6D1FXx09TbspSxlD?=
 =?us-ascii?Q?ClK8FWScpbtDCAyRy+PzwHk9eMSRpuw/AiepNTUKydqHdIssDAHF3d16QRjN?=
 =?us-ascii?Q?8g8jSvkfaoAJnG7165NjtvFBXdCZqDyEQ4RqksNE6GVnRay7LbNanLQN9Eg5?=
 =?us-ascii?Q?MuK8l8hUF20IdzrYlYysdbX3eoZbBsFxnv3aa2glrPMC/Ng04BC01X5Ny1UD?=
 =?us-ascii?Q?4rmIxRXT3AJFP9JsfFYOR4DlCkkOz0yymQMyMDzmxhj3W1Empuiz34vhP9m2?=
 =?us-ascii?Q?d3F9D931akBD+Fyb8lvd9YW5SrgMYy+mmiT8USzu5/pBsMREbEBut2usm3K3?=
 =?us-ascii?Q?s4KXsCb3RF3SVr1NmFOrjBuOVMNppotYEdFj4pjCtbfHlshYaDv+BkjFq0+7?=
 =?us-ascii?Q?J+hzutb+NpVFJ1I1degp22spn+TNji+Vg6hA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 19:30:30.6801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264c6ae5-a21c-4a50-c211-08ddf48e5521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315

Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> On Fri, 05 Sep 2025 13:48:26 -0500
> Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:
>> +++ b/drivers/dma/sdxi/descriptor.c
>
>> +enum {
>> +	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
>> +};
>> +
>> +#define sdxi_desc_field(_high, _low, _member) \
>> +	PACKED_FIELD(_high, _low, struct sdxi_desc_unpacked, _member)
>> +#define sdxi_desc_flag(_bit, _member) \
>> +	sdxi_desc_field(_bit, _bit, _member)
>> +
>> +static const struct packed_field_u16 common_descriptor_fields[] = {
>> +	sdxi_desc_flag(0, vl),
>> +	sdxi_desc_flag(1, se),
>> +	sdxi_desc_flag(2, fe),
>> +	sdxi_desc_flag(3, ch),
>> +	sdxi_desc_flag(4, csr),
>> +	sdxi_desc_flag(5, rb),
>> +	sdxi_desc_field(15, 8, subtype),
>> +	sdxi_desc_field(26, 16, type),
>> +	sdxi_desc_flag(448, np),
>> +	sdxi_desc_field(511, 453, csb_ptr),
>
> I'm not immediately seeing the advantage of dealing with unpacking in here
> when patch 2 introduced a bunch of field defines that can be used directly
> in the tests.

My idea is to use the bitfield macros (GENMASK etc) for the real code
that encodes descriptors while using the packing API in the tests for
those functions.

By limiting what's shared between the real code and the tests I get more
confidence in both. If both the driver code and the tests rely on the
bitfield macros, and then upon adding a new descriptor field I
mistranslate the bit numbering from the spec, that error is more likely
to propagate to the tests undetected than if the test code relies on a
separate mechanism for decoding descriptors.

I find the packing API quite convenient to use for the SDXI descriptor
tests since the spec defines the fields in terms of bit offsets that can
be directly copied to a packed_field_ array.


>> +};
>> +
>> +void sdxi_desc_unpack(struct sdxi_desc_unpacked *to,
>> +		      const struct sdxi_desc *from)
>> +{
>> +	*to = (struct sdxi_desc_unpacked){};
>> +	unpack_fields(from, sizeof(*from), to, common_descriptor_fields,
>> +		      SDXI_PACKING_QUIRKS);
>> +}
>> +EXPORT_SYMBOL_IF_KUNIT(sdxi_desc_unpack);
>
>> +int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
>> +			  const struct sdxi_cxt_stop *params)
>> +{
>> +	u16 cxt_start;
>> +	u16 cxt_end;
>
> I'd either combine like types, or assign at point of declaration to
> cut down on a few lines of code.

OK.


>> +	u64 csb_ptr;
>> +	u32 opcode;
>> +
>> +	opcode = (FIELD_PREP(SDXI_DSC_VL, 1) |
>> +		  FIELD_PREP(SDXI_DSC_FE, 1) |
>> +		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_STOP) |
>> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
>> +
>> +	cxt_start = params->range.cxt_start;
>> +	cxt_end = params->range.cxt_end;
>> +
>> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
>> +
>> +	desc_clear(desc);
>
> Not particularly important, but I'd be tempted to combine these with
>
> 	*desc = (struct sdxi_desc) {
> 		.ctx_stop = {
> 			.opcode = cpu_to_le32(opcode),
> 			.cxt_start = cpu_to_le16(cxt_start),
> 			.cxt_end = cpu_to_le16(cxt_end),
> 			.csb_ptr = cpu_to_le64(csb_ptr),
> 		},
> 	};
>
> To me that more clearly shows what is set and that the
> rest is zeroed.

Maybe I prefer your version too. Just mentioning in case it's not clear:
cxt_stop is a union member with the same size as the enclosing struct
sdxi_desc. Each member of struct sdxi_desc's interior anonymous union is
intended to completely overlay the entire object.

The reason for the preceding desc_clear() is that the designated
initializer construct does not necessarily zero padding bytes in the
object. Now, there *shouldn't* be any padding bytes in SDXI descriptors
as I've defined them, so I'm hoping the redundant stores are discarded
in the generated code. But I haven't checked this.

And it looks like I neglected to mark all the descriptor structs __packed,
oops.

I think I can add the __packed to struct sdxi_desc et al, use your
suggested initializer, and discard desc_clear().


>> +	desc->cxt_stop = (struct sdxi_dsc_cxt_stop) {
>> +		.opcode = cpu_to_le32(opcode),
>> +		.cxt_start = cpu_to_le16(cxt_start),
>> +		.cxt_end = cpu_to_le16(cxt_end),
>> +		.csb_ptr = cpu_to_le64(csb_ptr),
>> +	};
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_stop);
>> diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..141463dfd56bd4a88b4b3c9d45b13cc8101e1961
>> --- /dev/null
>> +++ b/drivers/dma/sdxi/descriptor.h
>> @@ -0,0 +1,107 @@
>
>> +/*
>> + * Fields common to all SDXI descriptors in "unpacked" form, for use
>> + * with pack_fields() and unpack_fields().
>> + */
>> +struct sdxi_desc_unpacked {
>> +	u64 csb_ptr;
>> +	u16 type;
>> +	u8 subtype;
>> +	bool vl;
>> +	bool se;
>> +	bool fe;
>> +	bool ch;
>> +	bool csr;
>> +	bool rb;
>> +	bool np;
>> +};
>> +
>> +void sdxi_desc_unpack(struct sdxi_desc_unpacked *to,
>> +		      const struct sdxi_desc *from);
>> +
>> +#endif /* DMA_SDXI_DESCRIPTOR_H */
>> diff --git a/drivers/dma/sdxi/descriptor_kunit.c b/drivers/dma/sdxi/descriptor_kunit.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..eb89d5a152cd789fb8cfa66b78bf30e583a1680d
>> --- /dev/null
>> +++ b/drivers/dma/sdxi/descriptor_kunit.c
>> @@ -0,0 +1,181 @@
>
>> +static void cxt_stop(struct kunit *t)
>> +{
>> +	struct sdxi_cxt_stop stop = {
>> +		.range = sdxi_cxt_range(1, U16_MAX)
>> +	};
>> +	struct sdxi_desc desc = {};
>> +	struct sdxi_desc_unpacked unpacked;
>> +
>> +	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_cxt_stop(&desc, &stop));
>> +
>> +	/* Check op-specific fields */
>> +	KUNIT_EXPECT_EQ(t, 0, desc.cxt_stop.vflags);
>> +	KUNIT_EXPECT_EQ(t, 0, desc.cxt_stop.vf_num);
>> +	KUNIT_EXPECT_EQ(t, 1, desc.cxt_stop.cxt_start);
>> +	KUNIT_EXPECT_EQ(t, U16_MAX, desc.cxt_stop.cxt_end);
>> +
>> +	/*
>> +	 * Check generic fields. Some flags have mandatory values
>> +	 * according to the operation type.
>> +	 */
>> +	sdxi_desc_unpack(&unpacked, &desc);
>
> Follow up on the comments on unpacking above, to me just pulling the
> values directly is simpler to follow.
>
> 	KUNIT_EXPECT_EQ(t, 0, FIELD_GET(desc.generic.opcode, SDXI_DSC_VL));
>
> or something along those lines.
>
>> +	KUNIT_EXPECT_EQ(t, unpacked.vl, 1);
>> +	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
>> +	KUNIT_EXPECT_EQ(t, unpacked.fe, 1);
>> +	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
>> +	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_STOP);
>> +	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
>> +	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
>> +	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
>> +}
>> +
>> +static struct kunit_case generic_desc_tcs[] = {
>> +	KUNIT_CASE(copy),
>> +	KUNIT_CASE(intr),
>> +	KUNIT_CASE(cxt_start),
>> +	KUNIT_CASE(cxt_stop),
>> +	{},
>
> Trivial but I'd drop that comma as nothing can come after this.

Sure.

