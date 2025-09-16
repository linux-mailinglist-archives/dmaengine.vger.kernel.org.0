Return-Path: <dmaengine+bounces-6536-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C853B5998B
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 16:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 375747AB5DE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F3F31A05B;
	Tue, 16 Sep 2025 14:21:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C230C606;
	Tue, 16 Sep 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032464; cv=none; b=Nqmg5HV2gRH+BoSviTEsFmnzjJ0/YzbMVaeMPqVmuS9dR1M+Cn+mP8kxqIVz0gZlW6RBtnZqJDkChNjBUEKrEX269v+cxzEhI322oe77y39LO8lnJ4+VhrvHTaxD/EkwLOc6NeMAjCfDQstAC8jK8hTwHtp6V8z5KRjEMvJcuS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032464; c=relaxed/simple;
	bh=p1am+g3ifY86Lf8CB4d9hKoIsb4z7QdDsy8ownC58v4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQcRlhV/68ktiayFVXyPO56q4WhF605lxsChq7qm3HYApT8WdVSD74diUHImNkotdla+GCGHiY/XA29+v8khDB5S3s1XnYSn6ke/nvMw+fP6kwRw3U6aBawKoDYOppnvSTtXHfFgMLjsVcfi5kxkKxx48/vM3OesFr2aQjImLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR3qL0yVnz6L5Dg;
	Tue, 16 Sep 2025 22:16:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 758F11402F5;
	Tue, 16 Sep 2025 22:20:59 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 16:20:58 +0200
Date: Tue, 16 Sep 2025 15:20:57 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch <nathan.lynch@amd.com>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>, Kees Cook
	<kees@kernel.org>
Subject: Re: [PATCH RFC 03/13] dmaengine: sdxi: Add descriptor encoding and
 unit tests
Message-ID: <20250916152057.00005f7a@huawei.com>
In-Reply-To: <87ms6va4z4.fsf@AUSNATLYNCH.amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-3-d0341a1292ba@amd.com>
	<20250915125226.000043c1@huawei.com>
	<87ms6va4z4.fsf@AUSNATLYNCH.amd.com>
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

On Mon, 15 Sep 2025 14:30:23 -0500
Nathan Lynch <nathan.lynch@amd.com> wrote:

+CC Kees given I refer to a prior discussion Kees helped out with
and this is a different related case.

> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> > On Fri, 05 Sep 2025 13:48:26 -0500
> > Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:  
> >> +++ b/drivers/dma/sdxi/descriptor.c  
> >  
> >> +enum {
> >> +	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
> >> +};
> >> +
> >> +#define sdxi_desc_field(_high, _low, _member) \
> >> +	PACKED_FIELD(_high, _low, struct sdxi_desc_unpacked, _member)
> >> +#define sdxi_desc_flag(_bit, _member) \
> >> +	sdxi_desc_field(_bit, _bit, _member)
> >> +
> >> +static const struct packed_field_u16 common_descriptor_fields[] = {
> >> +	sdxi_desc_flag(0, vl),
> >> +	sdxi_desc_flag(1, se),
> >> +	sdxi_desc_flag(2, fe),
> >> +	sdxi_desc_flag(3, ch),
> >> +	sdxi_desc_flag(4, csr),
> >> +	sdxi_desc_flag(5, rb),
> >> +	sdxi_desc_field(15, 8, subtype),
> >> +	sdxi_desc_field(26, 16, type),
> >> +	sdxi_desc_flag(448, np),
> >> +	sdxi_desc_field(511, 453, csb_ptr),  
> >
> > I'm not immediately seeing the advantage of dealing with unpacking in here
> > when patch 2 introduced a bunch of field defines that can be used directly
> > in the tests.  
> 
> My idea is to use the bitfield macros (GENMASK etc) for the real code
> that encodes descriptors while using the packing API in the tests for
> those functions.
> 
> By limiting what's shared between the real code and the tests I get more
> confidence in both. If both the driver code and the tests rely on the
> bitfield macros, and then upon adding a new descriptor field I
> mistranslate the bit numbering from the spec, that error is more likely
> to propagate to the tests undetected than if the test code relies on a
> separate mechanism for decoding descriptors.

That's a fair reason.  Perhaps add a comment just above the first
instance of this or top of file to express that?
> 
> I find the packing API quite convenient to use for the SDXI descriptor
> tests since the spec defines the fields in terms of bit offsets that can
> be directly copied to a packed_field_ array.
> 
> 
> >> +};

> >> +	u64 csb_ptr;
> >> +	u32 opcode;
> >> +
> >> +	opcode = (FIELD_PREP(SDXI_DSC_VL, 1) |
> >> +		  FIELD_PREP(SDXI_DSC_FE, 1) |
> >> +		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_STOP) |
> >> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
> >> +
> >> +	cxt_start = params->range.cxt_start;
> >> +	cxt_end = params->range.cxt_end;
> >> +
> >> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> >> +
> >> +	desc_clear(desc);  
> >
> > Not particularly important, but I'd be tempted to combine these with
> >
> > 	*desc = (struct sdxi_desc) {
> > 		.ctx_stop = {
> > 			.opcode = cpu_to_le32(opcode),
> > 			.cxt_start = cpu_to_le16(cxt_start),
> > 			.cxt_end = cpu_to_le16(cxt_end),
> > 			.csb_ptr = cpu_to_le64(csb_ptr),
> > 		},
> > 	};
> >
> > To me that more clearly shows what is set and that the
> > rest is zeroed.  
> 
> Maybe I prefer your version too. Just mentioning in case it's not clear:
> cxt_stop is a union member with the same size as the enclosing struct
> sdxi_desc. Each member of struct sdxi_desc's interior anonymous union is
> intended to completely overlay the entire object.
> 
> The reason for the preceding desc_clear() is that the designated
> initializer construct does not necessarily zero padding bytes in the
> object. Now, there *shouldn't* be any padding bytes in SDXI descriptors
> as I've defined them, so I'm hoping the redundant stores are discarded
> in the generated code. But I haven't checked this.

So, this one is 'fun' (and I can hopefully find the references)
The C spec has had some updates that might cover this though
I'm not sure and too lazy to figure it out today.  Anyhow,
that doesn't help anyway as we care about older compilers.

So we cheat and just check the compiler does fill them ;)

Via a reply Kees sent on a discussion of the somewhat related {}
https://lore.kernel.org/linux-iio/202505090942.48EBF01B@keescook/

https://elixir.bootlin.com/linux/v6.17-rc6/source/lib/tests/stackinit_kunit.c

I think the relevant one is __dynamic_all which is used with various hole sizes
and with both bare structures and unions.

+CC Kees who might have time to shout if I have this particular case wrong ;)



> 
> And it looks like I neglected to mark all the descriptor structs __packed,
> oops.
> 
> I think I can add the __packed to struct sdxi_desc et al, use your
> suggested initializer, and discard desc_clear().

That would indeed work.

> 
> 
> >> +	desc->cxt_stop = (struct sdxi_dsc_cxt_stop) {
> >> +		.opcode = cpu_to_le32(opcode),
> >> +		.cxt_start = cpu_to_le16(cxt_start),
> >> +		.cxt_end = cpu_to_le16(cxt_end),
> >> +		.csb_ptr = cpu_to_le64(csb_ptr),
> >> +	};

