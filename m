Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 163BA25152
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfEUOAv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 10:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfEUOAv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 10:00:51 -0400
Received: from localhost (unknown [106.51.105.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0791921479;
        Tue, 21 May 2019 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558447251;
        bh=B2pMNgUdKmU1cAmS6aYmbKhfcBaE02tqFqEBfSUGy3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAUzjmDTqsg1XPKB4jRXTJPq8vu9dHTzhkPag3QFY60QQq1ZTM1a2O2q54Gv4VHiA
         kI7E3I3rrv3A1XP+CL4/VU1R1kKiHR2vt0XwnE//KEgiCXkpmZn5NvYp1WIapOd0+i
         ARPZ9RgQKveXyCZ4x4m05+nSs/iWf+CT1TOG4Ops=
Date:   Tue, 21 May 2019 19:30:45 +0530
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
Subject: Re: [PATCH 1/4] dmaengine: mediatek: Add MediaTek UART APDMA support
Message-ID: <20190521140045.GO15118@vkoul-mobl>
References: <1556336193-15198-1-git-send-email-long.cheng@mediatek.com>
 <1556336193-15198-2-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556336193-15198-2-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-04-19, 11:36, Long Cheng wrote:
> Add 8250 UART APDMA to support MediaTek UART. If MediaTek UART is
> enabled by SERIAL_8250_MT6577, and we can enable this driver to offload
> the UART device moving bytes.

Applied, thanks

-- 
~Vinod
