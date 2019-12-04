Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF81125BA
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2019 09:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfLDIqF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Dec 2019 03:46:05 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:23584 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfLDIqF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Dec 2019 03:46:05 -0500
Received: from belgarion ([86.201.44.80])
        by mwinf5d08 with ME
        id Zklx2100E1jnNL603km3FG; Wed, 04 Dec 2019 09:46:04 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 04 Dec 2019 09:46:04 +0100
X-ME-IP: 86.201.44.80
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     dmaengine@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, kernel@pengutronix.de
Subject: Re: vchan helper broken wrt locking
References: <20191203115050.yvpaehsrck6zydmk@pengutronix.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 04 Dec 2019 09:45:57 +0100
In-Reply-To: <20191203115050.yvpaehsrck6zydmk@pengutronix.de> (Sascha Hauer's
        message of "Tue, 3 Dec 2019 12:50:50 +0100")
Message-ID: <87wobcxyuy.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> Hi All,

Hi Sascha,

The short story : from my understanding, vc->desc_free() shouldn't be called
with vd->lock held. The locking of callbacks called by virt-dma shouldn't be
handled by virt-dma, but be a part of the dma driver's architecture rather than
forced by virt-dma.

The long story :

This is what I remember and my understanding for the virt-dma :
 - virt_dma_chan->lock protects only :
   - all lists within virt_dma_chan
   - virt_dma_desc->node, which is on one of the above lists

As a consequence of this statement, this lock shouldn't be held for other parts
of the code, and therefore not while calling vc->desc_free().

I base the above statement on my "former" understanding, and that is a code I
dealt with years ago, so I might be a little rusty here and there.  The original
code Russell wrote states in virt-dma.h :
 - in structure "struct_dma_desc"
   The "protected by vc.lock" is just for the "node" field
 - in structure "struct virt_dma_chan"
   The "protected by vc.lock" is just above the 4 lists (originally 3, and the I
   added one more)

Now Peter might have more insight, as he has modified the code more recently
that I did.

Cheers.

--
Robert

PS: And yes, there are occurrences of list manipulations in virt-dma that should
be protected by vc.lock as you pointed out.
