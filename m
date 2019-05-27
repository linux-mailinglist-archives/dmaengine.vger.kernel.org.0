Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9B2AED7
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 08:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfE0Gkc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 02:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfE0Gkc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 02:40:32 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1584E2054F;
        Mon, 27 May 2019 06:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558939232;
        bh=BHfKzP74YWA7kcBQ/qwfq+fqK1Y003G+3r317SLetK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSaudunkYFzawMqo1bzztysqx2NNsUUvjh1TBGur6O9QjaRii8o8ti25T/Q2JX1Is
         mXG+tG1y/ASmhHkD4rE37rzWOfrT9wpOWmNIa2fFc5+x7cij7S+r7CUwJsR/CcQnXq
         jKUNd0SzyCA9X6F5yfStF6RmE+Q/ri5MzjQR+fsI=
Date:   Mon, 27 May 2019 12:10:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
Subject: Re: [PATCH 2/2] serial: 8250-mtk: modify uart DMA rx
Message-ID: <20190527064028.GF15118@vkoul-mobl>
References: <1558596909-14084-1-git-send-email-long.cheng@mediatek.com>
 <1558596909-14084-3-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558596909-14084-3-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-05-19, 15:35, Long Cheng wrote:
> Modify uart rx and complete for DMA

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
