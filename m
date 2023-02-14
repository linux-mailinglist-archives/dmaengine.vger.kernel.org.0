Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B293F696DB2
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 20:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBNTSp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 14:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBNTSo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 14:18:44 -0500
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C4F14217;
        Tue, 14 Feb 2023 11:18:41 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1676402318; bh=M5syd+xL2311kuoN57mCyNpR+LmxBuxfBcXd2LTsyvY=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=slqm7+oAI5AgPImuHdj7RJoie1ti4TrUhgx4bs+nyxjqoZHA31ItnK0N3bzKOg2cL
         J7yWQtIRXOIM+UBkLt7nqXFD+Ex84AHRDOeu/PSXtwfRb//QYCzOehHpp9dsKzSwvk
         b2wgHhyl9Z2sAX9FKFAuO85DNSdy0Y8RV0QM+m0w=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [RFC PATCH] dt-bindings: dma: apple,sio: Add schema
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <167638945429.3790.16067227881981242831.robh@kernel.org>
Date:   Tue, 14 Feb 2023 20:18:36 +0100
Cc:     Janne Grunau <j@jannau.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B75F1A1-E2DE-40D5-AA79-A764C65D8AD2@cutebit.org>
References: <20230214141053.92731-1-povik+lin@cutebit.org>
 <167638945429.3790.16067227881981242831.robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 14. 2. 2023, at 17:12, Rob Herring <robh@kernel.org> wrote:
> On Tue, 14 Feb 2023 15:10:53 +0100, Martin Povi=C5=A1er wrote:
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
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m =
dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> =
Documentation/devicetree/bindings/dma/apple,sio.example.dts:24.35-27.11: =
Warning (node_name_vs_property_name): /example-0/interrupt-controller: =
node name and property name conflict

I saw the warning, but since I had copied that part of the example from
apple,admac.yaml I didn=E2=80=99t make much of it. Now that I look at it =
again,
the example in apple,admac doesn=E2=80=99t raise the same warning, how =
come?

This is just a curiosity since we don=E2=80=99t need the aic node in the =
example
anyway (unlike in apple,admac where it=E2=80=99s needed because of empty =
entries
in interrupts-extended).

Martin

