Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389C74C13C5
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 14:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiBWNPN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 08:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiBWNPM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 08:15:12 -0500
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 05:14:43 PST
Received: from ocn-dfr-mts-106c2.ocn.ad.jp (ocn-dfr-mts-106c2.ocn.ad.jp [211.16.10.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BA0A996E;
        Wed, 23 Feb 2022 05:14:43 -0800 (PST)
Received: from ocn-ckd-mts-110c38.ocn.ad.jp (ocn-ckd-mts-110c38.ocn.ad.jp [211.16.13.103])
        by ocn-dfr-mts-106c2.ocn.ad.jp (Postfix) with ESMTP id C9AA5800066C;
        Wed, 23 Feb 2022 22:08:21 +0900 (JST)
Received: from mf-smf-ucb024c1.ocn.ad.jp (mf-smf-ucb024c1.ocn.ad.jp [153.153.66.160])
        by ocn-ckd-mts-110c38.ocn.ad.jp (Postfix) with ESMTP id CCA6948001178;
        Wed, 23 Feb 2022 22:08:18 +0900 (JST)
Received: from ocn-vc-mts-101c1.ocn.ad.jp ([153.153.66.78])
        by mf-smf-ucb024c1.ocn.ad.jp with ESMTP
        id MrNSnNQaD1lq8MrNSnzjm2; Wed, 23 Feb 2022 22:08:18 +0900
Received: from ocn-sdpx-mts-102c1.ocn.ad.jp ([211.16.10.135])
        by ocn-vc-mts-101c1.ocn.ad.jp with ESMTP
        id MrNRnB1upEZsNMrNRnWDuC; Wed, 23 Feb 2022 22:08:18 +0900
Received: from localhost (p1601136-ipoe.ipoe.ocn.ne.jp [114.172.254.135])
        by ocn-sdpx-mts-102c1.ocn.ad.jp (Postfix) with ESMTPA;
        Wed, 23 Feb 2022 22:08:17 +0900 (JST)
Date:   Wed, 23 Feb 2022 22:08:13 +0900 (JST)
Message-Id: <20220223.220813.1094415484971230882.anemo@mba.ocn.ne.jp>
To:     tsbogend@alpha.franken.de
Cc:     hauke@hauke-m.de, zajec5@gmail.com, macro@orcam.me.uk,
        paul@crapouillou.net, jiaxun.yang@flygoat.com,
        chenhuacai@kernel.org, matthias.bgg@gmail.com, vkoul@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove TX39XX support
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20220222090435.62571-1-tsbogend@alpha.franken.de>
References: <20220222090435.62571-1-tsbogend@alpha.franken.de>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 22 Feb 2022 10:04:28 +0100, Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> No (active) developer owns this hardware, so let's remove Linux support.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Good cleanup job!

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
