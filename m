Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3F66CDCBD
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 16:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjC2Ogm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Mar 2023 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjC2OgV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Mar 2023 10:36:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11A76A4
        for <dmaengine@vger.kernel.org>; Wed, 29 Mar 2023 07:32:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l12so15940079wrm.10
        for <dmaengine@vger.kernel.org>; Wed, 29 Mar 2023 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680100289;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hgZ/e6oLwPoPQ1aK11s+Ly2z6BUU28oJA4/et60gdgA=;
        b=PFEBt9fRT6zOH4hiwRMauzwDFJ0Lirss+OFvMLwQy3VG4YFjKdWttSXV2l1Ic2bDC+
         clZ2oJRyam3wCHz2WWcHe3DLZrcmcga5n4JBBrswu+sBOePBQTJmH2/4Qg7Yi14VcU9F
         Rk4k6/oAT79dEE4o7BwM0hD1m8wLdP7RFOECLqpxI8hJidL5cTOhpw/HOUrd7MOa/eCA
         9e9PGBuEDNh0wVC++2EHiLBEa/9sQC0q13XS8mhxVIw+tCWd13dSE/IQY7IyglCkfGts
         yAsRVWnyizL0NNWAjdh5p5RxDX5AmfqhuDMknDUNPPwWX33MM/2oEBJ5ot5mva3Ut8A1
         SUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100289;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgZ/e6oLwPoPQ1aK11s+Ly2z6BUU28oJA4/et60gdgA=;
        b=QygQKyrrK3S5Sdti3iM4ImjC4H4FPQvNp7aDpSg+HDzUA3dc0/ntBvKby0STfvQy5D
         hVni2iN//VCDJYUY47u1maXWdQwOXNBEOX4v5GNwtQ534ju2ocBsKrmTN6uubi8B7nMP
         34ac1hGLIzm7gfh5PMwThrtW9cI9ZpFTJH2gc1qVbiDnpqwGwcGVke296puO4T5fMVtE
         PWbDhoiTTLdd57GwC/yGPS/hc+ZIPFxMdFz5zEKm8sKan55t4AzFeguDNlYfdhjEPKpM
         zuJi1sQfm7gIg9nyTSnyFCxawkdkJAT4qybhA9mOpIu6WkD0Jw+CIEJlWp0KWYBNsZ75
         ZSeA==
X-Gm-Message-State: AAQBX9ejr5vb9wxg796zPqX+f0OxBizsUfYn6m35Dh/QrBzIYWR7TSk1
        FeD9BROG3JbOKnwew4vmrcz5RlfoBZhKxvtBZRpg533Y4Ek=
X-Google-Smtp-Source: AKy350bPwbw0F9g+zW/9GR6yF7z99W2vtyYbA2VP1hVRfS2ZVHNnmGyCCFDpjkJ5O78WtfnXWoVrTIDPi1VZb34Ght8=
X-Received: by 2002:a05:6000:511:b0:2c5:5817:f241 with SMTP id
 a17-20020a056000051100b002c55817f241mr3392582wrf.7.1680100288951; Wed, 29 Mar
 2023 07:31:28 -0700 (PDT)
MIME-Version: 1.0
From:   Kristof Havasi <havasiefr@gmail.com>
Date:   Wed, 29 Mar 2023 16:31:17 +0200
Message-ID: <CADBnMvj93bSO=+wU4=pLTgONV7w_hhecxQHAc_YS4P4GaqMNrA@mail.gmail.com>
Subject: dmaengine: at_hdmac: Regression regarding rs485 via dma in v5.4
To:     tudor.ambarus@microchip.com, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi there,

I was rebasing the Kernel branch of our SAMA5D35 based board from
v5.4.189 to v5.4.238.
I noticed that after the rebase we could _only send, but not receive_
through our RS485 interface.

I could bisect the problem to 77b97ef4908aa917e7b68667ec6b344cc5dc5034
in the v5.4.225 release. If I revert this commit, the tx/rx works just
like before.
Maybe this use-case wasn't considered when this patch was created?
I haven't seen a documentation change regarding this in DT bindings,
but if the config should be something else, please let me know.
Otherwise this commit breaks the RS485 function of atmel_serial at
least in the v5.4.y branch.

Best Regards,
Krist=C3=B3f Havasi

The relevant device tree nodes:

from sama5d3.dtsi:

usart1: serial@f0020000 {
  compatible =3D "atmel,at91sam9260-usart";
  reg =3D <0xf0020000 0x100>;
  interrupts =3D <13 IRQ_TYPE_LEVEL_HIGH 5>;
  dmas =3D <&dma0 2 AT91_DMA_CFG_PER_ID(5)>,
  <&dma0 2 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
  dma-names =3D "tx", "rx";
  pinctrl-names =3D "default";
  pinctrl-0 =3D <&pinctrl_usart1>;
  clocks =3D <&usart1_clk>;
  clock-names =3D "usart";
  status =3D "disabled";
};

pinctrl_usart1: usart1-0 {
  atmel,pins =3D
  <AT91_PIOB 28 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
   AT91_PIOB 29 AT91_PERIPH_A AT91_PINCTRL_NONE>;
};
pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
  atmel,pins =3D
  <AT91_PIOB 26 AT91_PERIPH_A AT91_PINCTRL_NONE /* PB26 periph A,
conflicts with GRX7 */
   AT91_PIOB 27 AT91_PERIPH_A AT91_PINCTRL_NONE>; /* PB27 periph A,
conflicts with G125CKO */
};

from our dts:

&usart1 {
  pinctrl-0 =3D <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
  atmel,use-dma-rx;
  atmel,use-dma-tx;
  rs485-rx-during-tx;
  linux,rs485-enabled-at-boot-time;
  status =3D "okay";
};

HW:
The SAMA5D3's PB27 is connected to the |RE+DE of the RS485 transceiver
SP3458EN-L
