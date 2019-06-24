Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F7650A4F
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfFXMEI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfFXMEH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Jun 2019 08:04:07 -0400
Received: from localhost (unknown [106.201.35.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12539212F5;
        Mon, 24 Jun 2019 12:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561377846;
        bh=Oz3COF33WpA043TGrrlVv1NbWayAXkghVvgEFRTlZ/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTRWMzH8naU0/87BsjrJicex3tVnB4dgKpKjYzEo7TCi30MNMaJXC/rIz2YsO97li
         Q8MpYUT0kQDq4SlMQoY2AI11743HqbzFsEloorlsDm3XyGGYvk5pcO85CO5hqaQSKj
         urdX2ebL6w9eNcT6i25nUauGxRAPywbAuh0fE//0=
Date:   Mon, 24 Jun 2019 17:30:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [V2] dmaengine: fsl-edma: support little endian for edma driver
Message-ID: <20190624120055.GB2962@vkoul-mobl>
References: <20190613102708.21606-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613102708.21606-1-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-06-19, 10:27, Peng Ma wrote:
> Our platforms with below registers(CHCFG0 - CHCFG15) of eDMA
> *-----------------------------------------------------------*
> |     Offset   | Big endian Register| Little endian Register|
> |--------------|--------------------|-----------------------|
> |     0x0      |        CHCFG0      |           CHCFG3      |
> |--------------|--------------------|-----------------------|
> |     0x1      |        CHCFG1      |           CHCFG2      |
> |--------------|--------------------|-----------------------|
> |     0x2      |        CHCFG2      |           CHCFG1      |
> |--------------|--------------------|-----------------------|
> |     0x3      |        CHCFG3      |           CHCFG0      |
> |--------------|--------------------|-----------------------|
> |     ...      |        ......      |           ......      |
> |--------------|--------------------|-----------------------|
> |     0xC      |        CHCFG12     |           CHCFG15     |
> |--------------|--------------------|-----------------------|
> |     0xD      |        CHCFG13     |           CHCFG14     |
> |--------------|--------------------|-----------------------|
> |     0xE      |        CHCFG14     |           CHCFG13     |
> |--------------|--------------------|-----------------------|
> |     0xF      |        CHCFG15     |           CHCFG12     |
> *-----------------------------------------------------------*
> 
> Current eDMA driver does not support Little endian, so this
> patch is to improve edma driver to support little endian.

Applied, thanks

-- 
~Vinod
