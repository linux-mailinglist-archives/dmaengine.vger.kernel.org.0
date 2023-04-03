Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0950C6D4D23
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjDCQF3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 12:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjDCQF1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 12:05:27 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBE92114;
        Mon,  3 Apr 2023 09:05:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3D0407DB;
        Mon,  3 Apr 2023 16:05:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3D0407DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680537920; bh=XfDtjdL03UON+Z3Zz6rkWcdyGXWekaxVNb7/+FX5L8U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sVrUAqyYPK7wSsQ8IJs1cDsAqIQ/9M607jLg0H46pR87YlOzoTwtrvkB5Ca9++4eV
         rVRylq4QWLWdF+KrHhSq6nK3BOogOa7QkuajwHrpYdID0IN0ATCQeTnHBKW0dNL/ua
         Z4ughGpDPqsftpwEvFcM/7JwtMRuh3ghV4Nb420mH8KwQO09ssHZB86HkrJblm2U1L
         mz9CGfPXhE5r8LjPc3zqHXmLKYagH/mxqcAFkf723WAb6gwyTaLktx4tB5apj6BR+T
         K+6Ra6vhXGLyk+MErb7swJ4Lq6p0uzTbi8MLv8XfBleCma21sb2mq8Au/ieY2dCj+3
         uqlbQ3tHjxg4A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Paul Cercueil <paul@crapouillou.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 11/11] Documentation: iio: Document high-speed DMABUF
 based API
In-Reply-To: <20230403154955.216148-2-paul@crapouillou.net>
References: <20230403154800.215924-1-paul@crapouillou.net>
 <20230403154955.216148-1-paul@crapouillou.net>
 <20230403154955.216148-2-paul@crapouillou.net>
Date:   Mon, 03 Apr 2023 10:05:19 -0600
Message-ID: <87zg7p7xz4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Paul Cercueil <paul@crapouillou.net> writes:

One nit:

> Document the new DMABUF based API.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
>
> ---
> v2: - Explicitly state that the new interface is optional and is
>       not implemented by all drivers.
>     - The IOCTLs can now only be called on the buffer FD returned by
>       IIO_BUFFER_GET_FD_IOCTL.
>     - Move the page up a bit in the index since it is core stuff and not
>       driver-specific.
> v3: Update the documentation to reflect the new API.
> ---
>  Documentation/iio/dmabuf_api.rst | 59 ++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst      |  2 ++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/iio/dmabuf_api.rst
>
> diff --git a/Documentation/iio/dmabuf_api.rst b/Documentation/iio/dmabuf_api.rst
> new file mode 100644
> index 000000000000..4d70372c7ebd
> --- /dev/null
> +++ b/Documentation/iio/dmabuf_api.rst
> @@ -0,0 +1,59 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================
> +High-speed DMABUF interface for IIO
> +===================================
> +
> +1. Overview
> +===========
> +
> +The Industrial I/O subsystem supports access to buffers through a
> +file-based interface, with read() and write() access calls through the
> +IIO device's dev node.
> +
> +It additionally supports a DMABUF based interface, where the userspace
> +can attach DMABUF objects (externally created) to a IIO buffer, and
> +subsequently use them for data transfers.
> +
> +A userspace application can then use this interface to share DMABUF
> +objects between several interfaces, allowing it to transfer data in a
> +zero-copy fashion, for instance between IIO and the USB stack.
> +
> +The userspace application can also memory-map the DMABUF objects, and
> +access the sample data directly. The advantage of doing this vs. the
> +read() interface is that it avoids an extra copy of the data between the
> +kernel and userspace. This is particularly useful for high-speed devices
> +which produce several megabytes or even gigabytes of data per second.
> +It does however increase the userspace-kernelspace synchronization
> +overhead, as the DMA_BUF_SYNC_START and DMA_BUF_SYNC_END IOCTLs have to
> +be used for data integrity.
> +
> +2. User API
> +===========
> +
> +As part of this interface, three new IOCTLs have been added. These three
> +IOCTLs have to be performed on the IIO buffer's file descriptor,
> +obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
> +
> +``IIO_BUFFER_DMABUF_ATTACH_IOCTL(int)``
> +----------------------------------------------------------------
> +
> +Attach the DMABUF object, identified by its file descriptor, to the IIO
> +buffer. Returns zero on success, and a negative errno value on error.

Rather than abusing subsections, this would be better done as a
description list:

  IIO_BUFFER_DMABUF_ATTACH_IOCTL(int)
      Attach the DMABUF object, identified by its file descriptor, to
      the IIO buffer. Returns zero on success, and a negative errno
      value on error.

Thanks,

jon
