Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C731670D444
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjEWGrk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 02:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjEWGrh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 02:47:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E17118;
        Mon, 22 May 2023 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684824455; x=1716360455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gVWbWiw/ZDPW0HOBd+nK8L6v2Q4lPpGLd6wth1TKIO8=;
  b=qKT+hR+Wh+HoFZMgkt1LApFrXNzkvSAUSXGwYUk8HFAeomi1nP/HCwGA
   WYqg9IGm+Rg2s2WbxcLvO1gxlzamXGz/TWz0lQwq0o7+fo0KwV7OPxkcx
   SeLFDy7+LZDrdvg+ShpKk/GsAgN7hgQIr3Y35vFGSs6OuN98Wxy54kzfc
   +mBbtIlPD3aIF+x/g8hFDzQInHUajRBWfCZuQyCu3esGiRJ1zaMiyyGhd
   ACurkMxOZxPUsqPQDRBQ8FdwBSqjCbqz6jKuxz5VIutb1ph86IUNMuIg2
   BJpj9KTnjvlsIT79Yu6/dDPBnYpbGU2SveRE01cUZPhWhKbMc1ga+hYIL
   A==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="asc'?scan'208";a="216790503"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 23:47:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 23:47:28 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 23:47:27 -0700
Date:   Tue, 23 May 2023 07:47:05 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Jaswinder Singh <jassisinghbrar@gmail.com>,
        Jaswinder Singh <jassi.brar@samsung.com>,
        Boojin Kim <boojin.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] dmaengine: pl330: rename _start to prevent build error
Message-ID: <20230523-lushly-purr-9a93ea9f3573@wendy>
References: <20230523000606.9405-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z31axD9H5YaGMLWg"
Content-Disposition: inline
In-Reply-To: <20230523000606.9405-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--Z31axD9H5YaGMLWg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Randy,

On Mon, May 22, 2023 at 05:06:06PM -0700, Randy Dunlap wrote:
> "_start" is used in several arches and proably should be reserved
> for ARCH usage. Using it in a driver for a private symbol can cause
> a build error when it conflicts with ARCH usage of the same symbol.
>=20
> Therefore rename pl330's "_start" to "_start_thread" so that there
> is no conflict and no build error.

_start_thread() seems pretty generic to me too, but there don't appear
to be any users & it is certainly better than the one causing build
issues!

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> drivers/dma/pl330.c:1053:13: error: '_start' redeclared as different kind=
 of symbol
>  1053 | static bool _start(struct pl330_thread *thrd)
>       |             ^~~~~~
> In file included from ../include/linux/interrupt.h:21,
>                  from ../drivers/dma/pl330.c:18:
> arch/riscv/include/asm/sections.h:11:13: note: previous declaration of '_=
start' with type 'char[]'
>    11 | extern char _start[];
>       |             ^~~~~~

--Z31axD9H5YaGMLWg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGxhZQAKCRB4tDGHoIJi
0rdIAP0Wabw96Kn9nVf+19fFM6AKRhl6z6gMm92JhKoWeudwbgEA7e0bLMA81R1s
DRBqxN4TNE5YBg3iPigE5gMne6P0KQ4=
=sBDX
-----END PGP SIGNATURE-----

--Z31axD9H5YaGMLWg--
