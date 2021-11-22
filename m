Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84140458936
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 07:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhKVGLh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 01:11:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhKVGLh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 01:11:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C2CC60E96;
        Mon, 22 Nov 2021 06:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637561311;
        bh=GytbicGsFa2Ux0yTg6oPNeDbhEolnv+pnW7LYbLJ16c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PotRZH119w+8xXkkOAsUGpJ80K5vP5JQkYLRo7o2UoOJQA3SsEwYRUTnVhvRBg9pg
         X31172d6OeZWZB4e/7aDExpZ2VeLl6uUzJ6k75s8xXAL8f72AqSI7An5vBnxoKpfrf
         KoZNQ8WFovV9yRWK7WW6tCZ+04MbMWEUiyRvCokvBxVWiQGIC/VsODoHzOlObUABFh
         3+Es7QW2Er1CkJqNDy1GYkiYWXqESmPsV3cmC83AWI//+lE6GB2b7YN2GNB/zjki64
         U9K5uG0JhgrWUie38aB6iKZEAcME2OC3z/UmVLf6NstjWDe7Pj7AQ7pA7V9TElyc9n
         YP39iu+UdDJUw==
Date:   Mon, 22 Nov 2021 11:38:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Adrian Larumbe <adrianml@alumnos.upm.es>
Cc:     dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] Add support for MEMCPY_SG transfers
Message-ID: <YZsz2h9D6Fj6Mpu1@matsya>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
 <20211101180825.241048-1-adrianml@alumnos.upm.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101180825.241048-1-adrianml@alumnos.upm.es>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-11-21, 18:08, Adrian Larumbe wrote:
> Bring back dmaengine API support for scatter-gather memcpy's.

Applied, thanks

-- 
~Vinod
