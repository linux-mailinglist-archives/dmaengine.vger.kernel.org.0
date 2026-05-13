Return-Path: <dmaengine+bounces-10445-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHQVEknzBGrMQgIAu9opvQ
	(envelope-from <dmaengine+bounces-10445-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 23:55:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA81353B310
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 23:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BCCA302DA0C
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 21:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547C23C9896;
	Wed, 13 May 2026 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSUNMpLw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142C3C9885;
	Wed, 13 May 2026 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709315; cv=none; b=e1yduajV+iJcN8VhMGl0bYAZfoL/zsDCZNNiA+nQztYJDEvjqp7ty5JIbkuVw60xySEp9+WcRGZyq0XsiundMvN+ZBYBf13Dhdw3gA28XkzBH9oZfVWhEymsYWmkYmZbCKCwCSla4pBopwUn5wxIF9Srk/XP/N09W9nJGJAVtQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709315; c=relaxed/simple;
	bh=rClCLv508MgKfMk65rpVSbbndmrOOFfdMf+W8DfDhlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fl4jjTaQQ1qufrg39f0yLZaJzGOCplQwltdGiN1GJOwpZHxe5RqI/ey1cCKGX7WzncUn5PI7VaxoQXakFL1ofNIs5wHGa7anoeIpSOq/xukgdlP/8bIpygxZo2sX887ya4JzgplNQP/nv5rPZFgU+2DScJKHSYlDJfpbFNtQ1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSUNMpLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD78DC19425;
	Wed, 13 May 2026 21:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778709314;
	bh=rClCLv508MgKfMk65rpVSbbndmrOOFfdMf+W8DfDhlA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WSUNMpLw3+lNg2crcjQLDqtZO+qoEYIhOQOP58HAXlprmYemZpWCQD4skpr7uUPiQ
	 AdtJQ2cNNawYqKgGd2Bo2JRpzkCwe+qp93ua79eNYiTxeC9/oMSkGfhdS4aMExrhmE
	 NuOagihDMlLNED7/cT+1jnPa0aZf0JxNn9BhGQIZOnH9oHgPDgPAHoJxqVKtLQetkN
	 l+Mo/fqzUdOuJUU6m2KtvFOPIu9h3+dwMkr+PAZoi4U+BlMbNIiF5YY9W3W9+oC979
	 IGIWW1LlxhzLK5tZLJhqrHhvRGkEh2j9RcyO3jY/vpBmfW2v28IjGm8rM/XCuLKrOz
	 QIWMtgLDlS3NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/23] dmaengine: sdxi: Add unit tests for descriptor
 encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260511-sdxi-base-v2-21-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-21-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:55:14 +0000
Message-Id: <20260513215514.AD78DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: DA81353B310
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10445-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Tests for `copy`, `cxt_start`, and `cxt_stop` bypass the `packin=
g` API verification by directly checking encoded descriptor fields.
- [Low] The `cxt_stop` test incorrectly references the `cxt_start` union me=
mber when verifying fields.
- [Low] The `sdxi_serialize_nop` encoder is entirely omitted from the test =
suite.
- [Low] The test suite setup function (`generic_desc_setup_device`) registe=
rs an unused mock device.
--

commit aa4cdaba4b4a985bdcf2f80d3a44e02557352cc5
Author: Nathan Lynch <nathan.lynch@amd.com>
Subject: dmaengine: sdxi: Add unit tests for descriptor encoding

This commit adds KUnit tests for encoding descriptors in the SDXI driver.
The tests use the packing API to decode descriptors produced by the driver
to verify the correct bit offsets without relying on bitmask macros.

> Test the encoder function for each descriptor type currently used by
> the driver.

Does this statement overlook the sdxi_serialize_nop encoder? It appears the
test suite entirely omits tests for sdxi_serialize_nop, leaving this API
untested.

> diff --git a/drivers/dma/sdxi/descriptor_kunit.c b/drivers/dma/sdxi/descr=
iptor_kunit.c
> new file mode 100644
> index 0000000000000..1f3c2e7ab2ddf
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor_kunit.c

[ ... ]

> +static void copy(struct kunit *t)
> +{

[ ... ]

> +	KUNIT_EXPECT_EQ(t, 0,
> +			sdxi_encode_copy(&desc,
> +					 &(struct sdxi_copy) {
> +						 .src =3D 0x1000,
> +						 .dst =3D 0x2000,
> +						 .len =3D 0x100,
> +						 .src_akey =3D 1,
> +						 .dst_akey =3D 2,
> +					 }));
> +	KUNIT_EXPECT_EQ(t, 0x1000, le64_to_cpu(desc.copy.addr0));
> +	KUNIT_EXPECT_EQ(t, 0x2000, le64_to_cpu(desc.copy.addr1));
> +	KUNIT_EXPECT_EQ(t, 0x100, 1 + le32_to_cpu(desc.copy.size));
> +	KUNIT_EXPECT_EQ(t, 1, le16_to_cpu(desc.copy.akey0));
> +	KUNIT_EXPECT_EQ(t, 2, le16_to_cpu(desc.copy.akey1));

The commit message states the tests use the packing API to decode descripto=
rs
without relying on bitmask definitions. Do these assertions bypass the pack=
ing
API verification by directly reading the encoded descriptor fields from the
struct?

If the struct layout in the header file is incorrect, could this allow both=
 the
driver and test code to share the same bug undetected?

[ ... ]

> +static void cxt_start(struct kunit *t)
> +{
> +	struct unpacked_desc unpacked;
> +	struct sdxi_cxt_start start =3D {
> +		.range =3D sdxi_cxt_range_single(2),
> +	};
> +	struct sdxi_desc desc;
> +
> +	desc_poison(&desc);
> +	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_start(&desc, &start));
> +
> +	unpack_cxt_start(&unpacked, &desc);
> +
> +	/* Check op-specific fields. */
> +	KUNIT_EXPECT_EQ(t, 0, desc.cxt_start.vflags);

Does this also bypass the packing API by directly reading the encoded descr=
iptor
field instead of verifying via the unpacked struct?

[ ... ]

> +static void cxt_stop(struct kunit *t)
> +{
> +	struct unpacked_desc unpacked;
> +	struct sdxi_cxt_stop stop =3D {
> +		.range =3D sdxi_cxt_range_single(2),
> +	};
> +	struct sdxi_desc desc;
> +
> +	desc_poison(&desc);
> +	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_stop(&desc, &stop));
> +
> +	unpack_cxt_stop(&unpacked, &desc);
> +
> +	/* Check op-specific fields. */
> +	KUNIT_EXPECT_EQ(t, 0, desc.cxt_start.vflags);

In addition to bypassing the packing API, does this incorrectly reference t=
he
cxt_start union member instead of cxt_stop when verifying fields?

[ ... ]

> +static int generic_desc_setup_device(struct kunit *t)
> +{
> +	struct device *dev =3D kunit_device_register(t, "sdxi-mock-device");
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(t, dev);
> +	t->priv =3D dev;
> +	return 0;
> +}

Is this mock device actually used by any of the tests in this suite? Lookin=
g at
the test cases, they appear to operate exclusively on memory buffers without
requiring a device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D21

