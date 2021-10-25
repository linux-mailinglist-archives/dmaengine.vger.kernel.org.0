Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F3438F92
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhJYGkQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhJYGkP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:40:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F32A560EE3;
        Mon, 25 Oct 2021 06:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635143873;
        bh=+/qu9xsmH5jt1RMI9oFtW+IIAXUG2z59y2qXAjAeEBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8A5e5wi9dGflUCaz86hXXkfTQT0x4GEWTfprtAWhyYyKb45apVXoDxTE4lcIrj6P
         1yAl4AT2FiaK9S2GH7Bbu2YuQVoIkzxljS5l3Kr0QbUT/3MUBPYyxVJiEjAE+CROb5
         A7QnQU1Q8LuEmCbzZyox3Km5MAwMi5MKrPuCHAFURS7S33HgnW5PYIezjTK98xf3SC
         nVJU0lEUfr2trBP+090ogo1dGXZmA/r6+tYltnM3jG+Y1k0Jfhcbpw7yPnJFOtCJeT
         NhWRiTMQ9gKPO1NVwdcUi5KWN6EFbfc9g/V0+kpRHrKptpLZtSJBNnf4AetpyDIOHZ
         MStoJjBJwlTLw==
Date:   Mon, 25 Oct 2021 12:07:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        dave.jiang@intel.com, john.wanghui@huawei.com
Subject: Re: [PATCH -next] dmaengine: idxd: Use list_move_tail instead of
 list_del/list_add_tail
Message-ID: <YXZQvdNR4cpy1Don@matsya>
References: <20210908092826.67765-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908092826.67765-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-09-21, 17:28, Bixuan Cui wrote:
> Using list_move_tail() instead of list_del() + list_add_tail()

Applied, thanks

-- 
~Vinod
