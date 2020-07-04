Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874692145E0
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jul 2020 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgGDMbV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 Jul 2020 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGDMbU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 4 Jul 2020 08:31:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D9C061794;
        Sat,  4 Jul 2020 05:31:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e13so30999188qkg.5;
        Sat, 04 Jul 2020 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wXVeQpxCI+iwkYlezHWcf0l5BZQJCmNvUa2xktmhOME=;
        b=E1+xoB3rYQ0NBSpfC4fscDTPs9mkC68MYowA8nh/JRikBI2XWSsFtvSpAqy9F494RE
         0leKOD5qmSi0BkobZ42sbTeyMRO7wxm14RZRZOhOxIkiX3nPIdCcI07bLj4olC9wYduq
         4uzBC4jqPKxwUhCHDDzrmTxxBr2d8T2olx/cn7pGcxJV0QBlkCfqUQ1Z4WLwivN3O4AS
         I4IC7dmrAZnY0A3r6sKrIcJAKFfJ5q/E6PEw3Ki+nZJnq+/3of4oB/1jISH3toeyuS33
         oW2FXmHLG7fLa359OKo8IrsP7AmFyTc4Cg0SKXtooxgf9uEF1gpG0pbPkyOSx9tEkoXI
         Ujcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wXVeQpxCI+iwkYlezHWcf0l5BZQJCmNvUa2xktmhOME=;
        b=cXeXnrW8rCJvnx00uR3VuX6ptamlzVDZPVasyNNkV8B6pfHk2Jgj6ZeeUV0/eQlT3G
         05YiRkiIOXsMMfkg+1XqMYzRi5rpNP3LtugYraQFfHYAcY6hzw8uID7+Sa8qbCdk119Q
         g/VjtpezpOcizJ91IHaxD4MosEILchlxXUDOm4bmjFXhRQkelOwBIPRiVmiX/EhW1b9U
         Kp/Aj3EOL9ImvkYlarngoyisKuOZ9nD104JqsuQidr9dUTCR7Va7Ea2lcunIIzgv4+Fx
         nAumeDqcZjTpSZkeU/37Kz+lV7T6pBwNmS/ilEvSduDoRHwOVnGSVbr4b2sh+wwnaIB8
         QoQg==
X-Gm-Message-State: AOAM530JipXxAEbQJ4UKV1xcvSNCd/cvmZayADwnl8th5A5YweFne69s
        Jkl/hOsFD/ILR3oidmHKx6g=
X-Google-Smtp-Source: ABdhPJxUcAycygrd/AP+v+wLXYj/t4ZGB/H3x+bdq/DHUXVvrvZSnflEAQw0KbOs9WzSAMnXvd0YaQ==
X-Received: by 2002:a37:6589:: with SMTP id z131mr39309316qkb.235.1593865879534;
        Sat, 04 Jul 2020 05:31:19 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id a25sm14159031qtk.40.2020.07.04.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 05:31:18 -0700 (PDT)
Date:   Sat, 4 Jul 2020 08:31:16 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH 00/17] Documentation/driver-api: eliminate duplicated
 words
Message-ID: <20200704123116.GB5194@shinobu>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2020 at 08:44:45PM -0700, Randy Dunlap wrote:
> Remove occurrences of duplicated words in Documentation/driver-api/.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: linux-ntb@googlegroups.com
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-usb@vger.kernel.org
> Cc: Eli Billauer <eli.billauer@gmail.com>
>=20
>=20
>  Documentation/driver-api/dmaengine/provider.rst        |    2 +-
>  Documentation/driver-api/driver-model/platform.rst     |    2 +-
>  Documentation/driver-api/firmware/built-in-fw.rst      |    2 +-
>  Documentation/driver-api/firmware/direct-fs-lookup.rst |    2 +-
>  Documentation/driver-api/firmware/firmware_cache.rst   |    2 +-
>  Documentation/driver-api/firmware/request_firmware.rst |    2 +-
>  Documentation/driver-api/generic-counter.rst           |    2 +-
>  Documentation/driver-api/iio/buffers.rst               |    2 +-
>  Documentation/driver-api/media/cec-core.rst            |    2 +-
>  Documentation/driver-api/media/dtv-frontend.rst        |    6 +++---
>  Documentation/driver-api/media/v4l2-controls.rst       |    4 ++--
>  Documentation/driver-api/media/v4l2-dev.rst            |    2 +-
>  Documentation/driver-api/ntb.rst                       |    2 +-
>  Documentation/driver-api/nvdimm/nvdimm.rst             |    2 +-
>  Documentation/driver-api/uio-howto.rst                 |    2 +-
>  Documentation/driver-api/usb/URB.rst                   |    2 +-
>  Documentation/driver-api/xillybus.rst                  |    2 +-
>  17 files changed, 20 insertions(+), 20 deletions(-)

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8AdpQACgkQhvpINdm7
VJIBvxAAqwgnnmzKHJ8nY2Ip3r9kE7Fygjzlzj9bHCF7iXLQVTYqC4W7cN0q0Bfu
QotqGgl0sAWKftn9qkvUzFI6TFRROjPuzPdDPucm+pQ5pW2m6HIEOgK42qjcuHLn
wvVJmYNuV3L+Y6NQtUS1PBulobtAYL8fMMhtQiG6rialiiB6yaJeHkpU7BP5cdUn
+n6i9IJIdl9//biQjBd5FQy7wqPLr+aXBZLAMSWT+hKl0huWGUXmFBTmcGLkGhAT
OEKrj9H7j8U7CmavcpNe0bHRLlucKl3a1wQTtf6CV+SwfaaFEtKhaEKEIsB4M9QI
sRvbV0gY9yJX2y3DabCS61B/EcCA2htBnk++AlNY+HvfXckvW9+g4xaMcCAU0cow
1EFaMIVEGWrEuaBIRDQJX5f9n97Wvc0Zp2B/hlxYvSo1xmaCObehZ9+UecKCW1C0
71A8NFc0cYiELXFZmQ+Vf7I9K3UeaRBaeoB8r4YEBNOO3JhmHq9E8re8ULoMvEse
HKZyuoGyoOhW27cZXoBw1ymZZ07Nnmpupyukmh9wQllQcMj5smqQAcbCtBNCcqXb
L+dlXBeIpE+KZHRFJ/2RtmDX903PaDcZ0Y5+NZUJsvt/KJCzg1rASkGcHC6lVTLj
4jBBZt4JmxUWKLxsdnkHXb12eTXPB7DkjhCiSThpm1A2Re9P4Jg=
=6Gqy
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
