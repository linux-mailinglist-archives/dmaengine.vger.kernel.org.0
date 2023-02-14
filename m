Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C861696E3D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 21:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjBNUCl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 15:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjBNUCk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 15:02:40 -0500
X-Greylist: delayed 20261 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Feb 2023 12:02:37 PST
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC262DE73;
        Tue, 14 Feb 2023 12:02:37 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1676404954; bh=Shdv6/ZcQzIt7yhST3CHJufWnCYjpSB75fBRBOSxd+0=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=iWYGC7YUqubuGS2vAtT84GYtuxST7LYKjC3Az57RqBIi1+tqmEmdQx0eaWmdnTz+2
         plOGtN3pscV8wqiw1KthB2s5389jaArJzD4cxbYpT9s/GAnin82Dxfdi2vooLNhWIw
         mM1HyaZJo3ycDOoArRMPTIzut8X2CV0p5qtq+OAo=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [RFC PATCH] dt-bindings: dma: apple,sio: Add schema
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20230214192544.GB27025-robh@kernel.org>
Date:   Tue, 14 Feb 2023 21:02:33 +0100
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <9938921C-29ED-4253-9F9D-4BA7432448F3@cutebit.org>
References: <20230214141053.92731-1-povik+lin@cutebit.org>
 <20230214192544.GB27025-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Thanks for the review!

> On 14. 2. 2023, at 20:25, Rob Herring <robh@kernel.org> wrote:
>=20
> On Tue, Feb 14, 2023 at 03:10:53PM +0100, Martin Povi=C5=A1er wrote:
>> Describe the SIO coprocessor which serves as pretend DMA controller =
on
>> recent Apple platforms.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>>=20
>> Since the schema mentions a loader preparing the binding =
appropriately,
>> here's a PR with the relevant (WIP) loader code, if anyone wants to =
look:
>> https://github.com/AsahiLinux/m1n1/pull/286
>>=20
>> .../devicetree/bindings/dma/apple,sio.yaml    | 129 =
++++++++++++++++++
>> 1 file changed, 129 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/dma/apple,sio.yaml
>>=20
>> diff --git a/Documentation/devicetree/bindings/dma/apple,sio.yaml =
b/Documentation/devicetree/bindings/dma/apple,sio.yaml
>> new file mode 100644
>> index 000000000000..a76cc8265e76
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/apple,sio.yaml

(...)

>> +  memory-region:
>> +    description:
>> +      A number of references to reserved memory regions among which =
are the DATA/TEXT
>> +      sections of coprocessor executable firmware and also auxiliary =
firmware data
>> +      describing the available DMA-enabled peripherals
>=20
> Can you define some range of number of entries.

I think I can provide a reliable lower bound (at least one segment with
DATA/TEXT and one segment with auxiliary data), and a conservative upper =
bound
(separate DATA/TEXT and no more than 6 segments of auxiliary data if =
each kind
of data has a segment of its own). I will work it in into the next =
version.

Martin

