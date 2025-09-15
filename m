Return-Path: <dmaengine+bounces-6509-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C766B5794F
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 13:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA3E1A25A4E
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEAA30103D;
	Mon, 15 Sep 2025 11:52:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5F3009F2;
	Mon, 15 Sep 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937154; cv=none; b=Q8QjDpdNgrycaya7jLo74MvQkNnEml9XNMGOKSHrXgaXNSpy2AUBL3uy8kp87Gt8fG+e9JhMUFKz86abe42nlUwGCG6mpD0uGxwm4QP/T0/IsulN3YsLXYFmRnhIUa3ei8ZD9nLzf/R+WcXIeCCl6H7jNt0wtQHI086uWyneBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937154; c=relaxed/simple;
	bh=54tl+6pOl4LZUAW80ZUYCb6Pc++HjQTswwD27qaOm54=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+8+VeWuJcIAogGAbWkQm8q6GnWMLfbuFe0kpI3KUOUzamf126f2nelIOjFcxx2SFM/ywAKJ8bi4T+w2Qu9GKT4TakaF+XjCiCmqUkPwdq0ocma51vDtn/Xp0wFdzjgtZqvJgfh7hl9hvft4/izr8rrlwfsr3PXhtWCgqm1HAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQNcR1Lxfz6M5jp;
	Mon, 15 Sep 2025 19:49:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B38181400DC;
	Mon, 15 Sep 2025 19:52:28 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 13:52:28 +0200
Date: Mon, 15 Sep 2025 12:52:26 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
CC: <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 03/13] dmaengine: sdxi: Add descriptor encoding and
 unit tests
Message-ID: <20250915125226.000043c1@huawei.com>
In-Reply-To: <20250905-sdxi-base-v1-3-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-3-d0341a1292ba@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 05 Sep 2025 13:48:26 -0500
Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:

> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Add support for encoding several types of SDXI descriptors:
> 
> * Copy
> * Interrupt
> * Context start
> * Context stop
> 
> Each type of descriptor has a corresponding parameter struct which is
> an input to its encoder function. E.g. to encode a copy descriptor,
> the client initializes a struct sdxi_copy object with the source,
> destination, size, etc and passes that to sdxi_encode_copy().
> 
> Include unit tests that verify that encoded descriptors have the
> expected values and that fallible encode functions fail on invalid
> inputs.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Hi,
A few comments inline. Mostly it is a case of personal taste
vs what I'm seeing as complexity that is needed.

Jonathan


> ---
>  drivers/dma/sdxi/.kunitconfig       |   4 +
>  drivers/dma/sdxi/descriptor.c       | 197 ++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/descriptor.h       | 107 ++++++++++++++++++++
>  drivers/dma/sdxi/descriptor_kunit.c | 181 +++++++++++++++++++++++++++++++++
>  4 files changed, 489 insertions(+)
> 
> diff --git a/drivers/dma/sdxi/.kunitconfig b/drivers/dma/sdxi/.kunitconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..a98cf19770f03bce82ef86d378d2a2e34da5154a
> --- /dev/null
> +++ b/drivers/dma/sdxi/.kunitconfig
> @@ -0,0 +1,4 @@
> +CONFIG_KUNIT=y
> +CONFIG_DMADEVICES=y
> +CONFIG_SDXI=y
> +CONFIG_SDXI_KUNIT_TEST=y
> diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..6ea5247bf8cdaac19131ca5326ba1640c0b557f8
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor.c

> +enum {
> +	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
> +};
> +
> +#define sdxi_desc_field(_high, _low, _member) \
> +	PACKED_FIELD(_high, _low, struct sdxi_desc_unpacked, _member)
> +#define sdxi_desc_flag(_bit, _member) \
> +	sdxi_desc_field(_bit, _bit, _member)
> +
> +static const struct packed_field_u16 common_descriptor_fields[] = {
> +	sdxi_desc_flag(0, vl),
> +	sdxi_desc_flag(1, se),
> +	sdxi_desc_flag(2, fe),
> +	sdxi_desc_flag(3, ch),
> +	sdxi_desc_flag(4, csr),
> +	sdxi_desc_flag(5, rb),
> +	sdxi_desc_field(15, 8, subtype),
> +	sdxi_desc_field(26, 16, type),
> +	sdxi_desc_flag(448, np),
> +	sdxi_desc_field(511, 453, csb_ptr),

I'm not immediately seeing the advantage of dealing with unpacking in here
when patch 2 introduced a bunch of field defines that can be used directly
in the tests. 

> +};
> +
> +void sdxi_desc_unpack(struct sdxi_desc_unpacked *to,
> +		      const struct sdxi_desc *from)
> +{
> +	*to = (struct sdxi_desc_unpacked){};
> +	unpack_fields(from, sizeof(*from), to, common_descriptor_fields,
> +		      SDXI_PACKING_QUIRKS);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_desc_unpack);

> +int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_stop *params)
> +{
> +	u16 cxt_start;
> +	u16 cxt_end;

I'd either combine like types, or assign at point of declaration to
cut down on a few lines of code.

> +	u64 csb_ptr;
> +	u32 opcode;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_VL, 1) |
> +		  FIELD_PREP(SDXI_DSC_FE, 1) |
> +		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_STOP) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
> +
> +	cxt_start = params->range.cxt_start;
> +	cxt_end = params->range.cxt_end;
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	desc_clear(desc);

Not particularly important, but I'd be tempted to combine these with

	*desc = (struct sdxi_desc) {
		.ctx_stop = {
			.opcode = cpu_to_le32(opcode),
			.cxt_start = cpu_to_le16(cxt_start),
			.cxt_end = cpu_to_le16(cxt_end),
			.csb_ptr = cpu_to_le64(csb_ptr),
		},
	};

To me that more clearly shows what is set and that the
rest is zeroed.

> +	desc->cxt_stop = (struct sdxi_dsc_cxt_stop) {
> +		.opcode = cpu_to_le32(opcode),
> +		.cxt_start = cpu_to_le16(cxt_start),
> +		.cxt_end = cpu_to_le16(cxt_end),
> +		.csb_ptr = cpu_to_le64(csb_ptr),
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_stop);
> diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..141463dfd56bd4a88b4b3c9d45b13cc8101e1961
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor.h
> @@ -0,0 +1,107 @@

> +/*
> + * Fields common to all SDXI descriptors in "unpacked" form, for use
> + * with pack_fields() and unpack_fields().
> + */
> +struct sdxi_desc_unpacked {
> +	u64 csb_ptr;
> +	u16 type;
> +	u8 subtype;
> +	bool vl;
> +	bool se;
> +	bool fe;
> +	bool ch;
> +	bool csr;
> +	bool rb;
> +	bool np;
> +};
> +
> +void sdxi_desc_unpack(struct sdxi_desc_unpacked *to,
> +		      const struct sdxi_desc *from);
> +
> +#endif /* DMA_SDXI_DESCRIPTOR_H */
> diff --git a/drivers/dma/sdxi/descriptor_kunit.c b/drivers/dma/sdxi/descriptor_kunit.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..eb89d5a152cd789fb8cfa66b78bf30e583a1680d
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor_kunit.c
> @@ -0,0 +1,181 @@

> +static void cxt_stop(struct kunit *t)
> +{
> +	struct sdxi_cxt_stop stop = {
> +		.range = sdxi_cxt_range(1, U16_MAX)
> +	};
> +	struct sdxi_desc desc = {};
> +	struct sdxi_desc_unpacked unpacked;
> +
> +	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_cxt_stop(&desc, &stop));
> +
> +	/* Check op-specific fields */
> +	KUNIT_EXPECT_EQ(t, 0, desc.cxt_stop.vflags);
> +	KUNIT_EXPECT_EQ(t, 0, desc.cxt_stop.vf_num);
> +	KUNIT_EXPECT_EQ(t, 1, desc.cxt_stop.cxt_start);
> +	KUNIT_EXPECT_EQ(t, U16_MAX, desc.cxt_stop.cxt_end);
> +
> +	/*
> +	 * Check generic fields. Some flags have mandatory values
> +	 * according to the operation type.
> +	 */
> +	sdxi_desc_unpack(&unpacked, &desc);

Follow up on the comments on unpacking above, to me just pulling the
values directly is simpler to follow.

	KUNIT_EXPECT_EQ(t, 0, FIELD_GET(desc.generic.opcode, SDXI_DSC_VL));

or something along those lines.

> +	KUNIT_EXPECT_EQ(t, unpacked.vl, 1);
> +	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.fe, 1);
> +	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_STOP);
> +	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
> +	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
> +}
> +
> +static struct kunit_case generic_desc_tcs[] = {
> +	KUNIT_CASE(copy),
> +	KUNIT_CASE(intr),
> +	KUNIT_CASE(cxt_start),
> +	KUNIT_CASE(cxt_stop),
> +	{},

Trivial but I'd drop that comma as nothing can come after this.

> +};

