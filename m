Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA057D5CC2
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 09:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfJNHxg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 03:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfJNHxg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 03:53:36 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E997120854;
        Mon, 14 Oct 2019 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571039615;
        bh=P8XFRaZj1VIoW3IbXhwvG/bv7PGeiuZZ5NlCw4f1mA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obWXoQJtK9LfknGhzMO1NyIDmWN0fGS6b97zRNiymEy4Rui/zKRMvcAX0Diai3nWb
         ARFASeMUIQ6bihmsVegYoBqccrGqQiXxo9aY6UwlgXelQug4VNvgZvRAN54vAXf0cD
         Q6/48ln+tfwIMFm7BzlS3Bnp8mVlmv3+L9nGOKds=
Date:   Mon, 14 Oct 2019 13:23:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] dmaengine: at_xdmac: Use
 devm_platform_ioremap_resource() in at_xdmac_probe()
Message-ID: <20191014075332.GK2654@vkoul-mobl>
References: <377247f3-b53a-a9d9-66c7-4b8515de3809@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377247f3-b53a-a9d9-66c7-4b8515de3809@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-09-19, 10:48, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 10:37:31 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.

Applied, thanks

-- 
~Vinod
