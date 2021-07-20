Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4AF3CFB42
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhGTNM7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 09:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238600AbhGTNHk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 09:07:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36E7D61164;
        Tue, 20 Jul 2021 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626788899;
        bh=5p+n+PS0ikQhy+HBLFOc7WHd4BkzD4jVZiIU0FOW0/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YjIU/fe5Gl9Qt3kNiBSpbrJakePv6KLJIPZEJVD3+EMoZHIHgw1dBkW8QPgh2rBzm
         ZDF7tE0VWGfNRyj1EYq41M6gS962kzZUdRIqi+/tX9PUAKBGPGiZTX5gOf1B4qPneG
         mdLajN+8jQzJNb3vCqdBTRAUJ8CmzeEeLJpY4ABTZS7Pb1eOZt/CevjimQN77Qs1er
         krkjJ8FjZ9rV9UwYrwKx8jJfVBX+a2YqA4zI0Wibx/3R+AvATXuV8VeYQTX1EYQx6o
         5MEdANQ3Sj+WlNDf6EDTkALvc/pPxfc1G5UnJwz/IdoprUxHNUy2/iVzhTqeXIz01I
         VItQy/Nzu9L4A==
Date:   Tue, 20 Jul 2021 19:18:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH] dmaengine: idxd: fix sequence for pci driver remove()
 and shutdown()
Message-ID: <YPbUH7w3gHGsxRfG@matsya>
References: <162629983901.395844.17964803190905549615.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162629983901.395844.17964803190905549615.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-07-21, 14:57, Dave Jiang wrote:
> ->shutdown() call should only be responsible for quiescing the device.
> Currently it is doing PCI device tear down. This causes issue when things
> like MMIO mapping is removed while idxd_unregister_devices() will trigger
> removal of idxd device sub-driver and still initiates MMIO writes to the
> device. Another issue is with the unregistering of idxd 'struct device',
> the memory context gets freed. So the teardown calls are accessing freed
> memory and can cause kernel oops. Move all the teardown bits that doesn't
> belong in shutdown to ->remove() call. Move unregistering of the idxd
> conf_dev 'struct device' to after doing all the teardown to free all
> the memory that's no longer needed.

Applied to fixes, thanks

-- 
~Vinod
