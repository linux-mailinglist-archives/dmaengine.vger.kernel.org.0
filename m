Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B69297822
	for <lists+dmaengine@lfdr.de>; Fri, 23 Oct 2020 22:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755985AbgJWUR2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Oct 2020 16:17:28 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:46176 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750409AbgJWUR2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Oct 2020 16:17:28 -0400
Received: from belgarion ([86.195.143.34])
        by mwinf5d48 with ME
        id jYH82300E0kkUce03YHNua; Fri, 23 Oct 2020 22:17:24 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 23 Oct 2020 22:17:24 +0200
X-ME-IP: 86.195.143.34
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 10/10] dmaengine: pxa_dma: remove redundant irqsave and irqrestore in hardIRQ
References: <20201015235921.21224-1-song.bao.hua@hisilicon.com>
        <20201015235921.21224-11-song.bao.hua@hisilicon.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 23 Oct 2020 22:16:55 +0200
In-Reply-To: <20201015235921.21224-11-song.bao.hua@hisilicon.com> (Barry
        Song's message of "Fri, 16 Oct 2020 12:59:21 +1300")
Message-ID: <87sga4wvd4.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Barry Song <song.bao.hua@hisilicon.com> writes:

> Running in hardIRQ, disabling IRQ is redundant.
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Why not.
I would have liked a longer commit message to explain the reason of the patch,
which probably is a performance optimization (ie. not disabling twice IRQs).

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
