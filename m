Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF2973E5E1
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jun 2023 18:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjFZQ6H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Jun 2023 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFZQ6G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Jun 2023 12:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108EE70;
        Mon, 26 Jun 2023 09:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24B5B60F03;
        Mon, 26 Jun 2023 16:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB6CC433C0;
        Mon, 26 Jun 2023 16:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687798684;
        bh=/6I63s7oZUF/1wqTNsxPn1YgT6ZobbD3eXioGmc3G/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o83I7RypfgU8zTzvTx88NpFp0ncROj1AIGY2xPjTLo9lq5ZovSrkJ+qXQI+oOLWS7
         F+7lc5dnMBj2bX3HRGwoeWczvyWcJNPejITz9faSFfZsfPnUNI0xITp7WqDbTvx3Vy
         FmtgLyIPFf3k5QfUbwNKBsuX+en4CX1AKRBgF3r5mzqTRw5b8+MajnqO6pvOsT30sQ
         oqUhgT7W/tH4ctHEhHYG6VbTTvDulIrmwpVGouFSKAZRqCmLfjIEVT2Pm8x/ZRfqPJ
         drs/77U/uiXaETX/tEqjuVBnH6ndXcSZJg+w+rntr1BX2N2NzFAKL8jtMEuishXFCZ
         pIvZd54KS2Qfw==
Date:   Mon, 26 Jun 2023 17:57:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: qcom,bam: require one of control
 methods
Message-ID: <20230626-prewashed-maximum-8402dffe790a@spud>
References: <20230626145645.646136-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="an2WmpP2EaKyfAAz"
Content-Disposition: inline
In-Reply-To: <20230626145645.646136-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--an2WmpP2EaKyfAAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 04:56:45PM +0200, Krzysztof Kozlowski wrote:
> The BAM DMA resources can be controlled remotely (e.g. by trusted
> environment; needs qcom,powered-remotely or qcom,controlled-remotely
> properties) or locally.  In the latter case we need to provide its
> clock.
>=20
> Require one of methods of such control to properly validate DTS.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--an2WmpP2EaKyfAAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJnDlwAKCRB4tDGHoIJi
0qvEAQCi8S8dOZMpZcg0mY35taaqCaat6zIesocGIE3Hb2Tv9QD/Qzv3V3PMb6UR
WAHy4wxo3ps6MrCkwY06Fu9ADJt+PQk=
=q2cz
-----END PGP SIGNATURE-----

--an2WmpP2EaKyfAAz--
