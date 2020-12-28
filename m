Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50D2E3F1A
	for <lists+dmaengine@lfdr.de>; Mon, 28 Dec 2020 15:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505245AbgL1OfB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Dec 2020 09:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505225AbgL1OfA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 28 Dec 2020 09:35:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 196CE208B6;
        Mon, 28 Dec 2020 14:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609166059;
        bh=ogKcYkMw9ARzUKF21VmoE9vp/OT8fP5rL3ZGtMvoMDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYWTZ9tzG3dASXGRvFijK93GYHKBOz+qKNOQu/g4BlfZya9eLTcntZ7Nlql4qaUTq
         7CR2tycoArNSxqesLE+c3Jf+PQr8YYxT3b5c2VUhjiB7UBKl+I/3Z7vvWII1xqDh71
         7U0C+AVXy+mLmO1zHTTSO5tfbYjxs+uxrb73DWbc=
Date:   Mon, 28 Dec 2020 15:25:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
Message-ID: <X+nq1JJLxyVr7Ih+@kroah.com>
References: <20201222040645.1323611-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222040645.1323611-1-robh@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 21, 2020 at 09:06:45PM -0700, Rob Herring wrote:
> 'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
> preferred for a single entry while greater than 1 should have an 'items'
> list.
> 
> A meta-schema check for this is pending once these existing cases are
> fixed.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: dmaengine@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
