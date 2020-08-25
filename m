Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B623251C63
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 17:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHYPh1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 11:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHYPh0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 11:37:26 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6684420782;
        Tue, 25 Aug 2020 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598369846;
        bh=A0hNpMnV1b6qRm4pZRusQY0GV5RU079gfbvhqvOfrgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JRPhmo6bGT0hsRlvDavbKomectz6Sx6p3xDanZoQfzsRTm8n47SYOMBIPigouj171
         1a12vqP1rUfqWDOPVUqHjAwHbZMJKa/9U6h6biI8ovoAhOURmSBEf4wyeSdlfmjTS0
         yxTQ1kZrmh9QGLveUWAGRD9BEtwC7ENNSHeZh1uA=
Date:   Tue, 25 Aug 2020 21:07:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, dan.j.williams@intel.com, ardeleanalex@gmail.com
Subject: Re: [RESEND PATCH v2 0/6] dmaengine: axi-dmac: add support for
 reading bus attributes from register
Message-ID: <20200825153722.GU2639@vkoul-mobl>
References: <20200825151950.57605-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825151950.57605-1-alexandru.ardelean@analog.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-08-20, 18:19, Alexandru Ardelean wrote:
> The series adds support for reading the DMA bus attributes from the
> INTERFACE_DESCRIPTION (0x10) register.
> 
> The first 5 changes are a bit of rework prior to adding the actual
> change in patch 6, as things need to be shifted around a bit, to enable 
> the clock to be enabled earlier, to be able to read the version
> register.

Applied, thanks

-- 
~Vinod
