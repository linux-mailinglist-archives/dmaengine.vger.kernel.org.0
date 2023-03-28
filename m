Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A11D6CB5C2
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 07:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjC1FFZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 01:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1FFY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 01:05:24 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734D6106
        for <dmaengine@vger.kernel.org>; Mon, 27 Mar 2023 22:05:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id i6so13582708ybu.8
        for <dmaengine@vger.kernel.org>; Mon, 27 Mar 2023 22:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679979922;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jrPzyNKILilfkJFnFnLXXP/rj7p3oM271F7TMZaj07g=;
        b=RfAoYRrp/ry3w6Qu6wCXR0DV84TkBrUbkfxRatXNGNVsi/U/EN1Q2fsTERXgz2FDBr
         zhmhMIBH/BxGDF19/wtk67stxPyp2n0Z98cewhWnmVwpwbL85qV/gC0b8L8frCxgmD/d
         gDlZba9aDc2U8DQOfCyNXSfA1r5Hkqwmgwjh3MtC4/rQgFwzD81mqj3biHtKYacDCTMw
         9m895W6944SMxF47JkoZP6WdvD7Q6ohKOBiDMKU4pFHRlrkBhoH6LGb1oYy8vxOCg+9L
         uLPRTQe96GpK+SgwOzRVHifjSTiIGNhjcYIVyPkxmrHWNJFuJmwLJVuY8Lvm/IlGFwQh
         fW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679979922;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrPzyNKILilfkJFnFnLXXP/rj7p3oM271F7TMZaj07g=;
        b=AqAJBxitzL2Cc3IVONXKWVpB66Ut7ldXqkOHV9qxKKYcq0QrMF1Zv+SZtxfmS1ul2E
         oO4EB8ftG6+rbpX1UWF8bkXLX/azrkVNlqwsnBln3ypk3Axggz3gG6IOvPWfpVeyXuzM
         HPiWhIqjLB0gbJlTt/4LgO95gLjl+SzvEeD/ReivQEqqT8V7CRSJ8ZeXogrYXjYqHpA2
         VSY4EUkRHx7bxxq/680JmpErw09AIoLyH5zgRK8Xr2klTbnnJFKpRv2ofxc2TsBYXfIy
         M33MHH46paoTlI4by9fWACVTpS4OLl0NGbV9lfQ1kIdC36I5e5mjq3AZR+485LhwvHg0
         b9iQ==
X-Gm-Message-State: AAQBX9d3DisXoK6ncS70jnQ0g0/XyFspnJpU2turKGzKHVhNBn8/Qjs/
        oYnWTYc6KBUAqQ7ESyIozyhjT9PfljCx/XzwFjOx0IHBhnqt4A==
X-Google-Smtp-Source: AKy350YD5EDHsaYe/O3bddm4iPZVSu/jTdz7pjuY3tkR/rdTvaBa8cAVI1v0zpaz8mhbMgpkJ4GXL/D1/Z+qVOsIDQA=
X-Received: by 2002:a05:6902:102e:b0:b6a:2590:6c63 with SMTP id
 x14-20020a056902102e00b00b6a25906c63mr11816848ybt.2.1679979922516; Mon, 27
 Mar 2023 22:05:22 -0700 (PDT)
MIME-Version: 1.0
From:   Rosen Penev <rosenp@gmail.com>
Date:   Mon, 27 Mar 2023 22:05:11 -0700
Message-ID: <CAKxU2N9yHa7ia_=07Csa7dDsZxcbPMmGSZKr+UxRSWH1VpG1fw@mail.gmail.com>
Subject: mv_xor error during mdadm array creation
To:     dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I noticed this when I created my array. Not sure if it's something to
worry about. Device is an Armada 38x with 4 SATA ports.

[22404.763561] WARNING: CPU: 1 PID: 2013 at
crypto/async_tx/async_xor.c:228 async_xor_offs+0x3cf/0x3d8 [async_xor]
[22404.763581] async_xor_offs: no space for dma address conversion
[22404.763584] Modules linked in: aufs aes_arm_bs crypto_simd
cast5_generic cast_common blowfish_generic blowfish_common
algif_skcipher af_alg overlay cp210x usbserial orion_wdt at24 pwm_fan
wireguard curve25519_neon libcurve25519_generic libchacha20poly1305
chacha_neon poly1305_arm ip6_udp_tunnel udp_tunnel pkcs8_key_parser
softdog lm75 marvell_cesa libdes configfs sunrpc ip_tables x_tables
autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx raid1 raid0 multipath linear md_mod uas
[22404.763688] CPU: 1 PID: 2013 Comm: md0_raid5 Not tainted
5.15.89-mvebu #22.11.4
[22404.763695] Hardware name: Marvell Armada 380/385 (Device Tree)
[22404.763704] [<c010c301>] (unwind_backtrace) from [<c0108927>]
(show_stack+0xb/0xc)
[22404.763722] [<c0108927>] (show_stack) from [<c080d685>]
(dump_stack_lvl+0x2b/0x34)
[22404.763734] [<c080d685>] (dump_stack_lvl) from [<c08087f5>]
(__warn+0x7d/0x8e)
[22404.763749] [<c08087f5>] (__warn) from [<c080885f>]
(warn_slowpath_fmt+0x59/0x70)
[22404.763760] [<c080885f>] (warn_slowpath_fmt) from [<bf8523cf>]
(async_xor_offs+0x3cf/0x3d8 [async_xor])
[22404.763774] [<bf8523cf>] (async_xor_offs [async_xor]) from
[<bf86bb6d>] (raid_run_ops+0xb01/0x110c [raid456])
[22404.763820] [<bf86bb6d>] (raid_run_ops [raid456]) from [<bf86fe29>]
(handle_stripe+0x6d5/0x1f4c [raid456])
[22404.763867] [<bf86fe29>] (handle_stripe [raid456]) from
[<bf871951>] (handle_active_stripes.constprop.21+0x2b1/0x3c8
[raid456])
[22404.763914] [<bf871951>] (handle_active_stripes.constprop.21
[raid456]) from [<bf871e45>] (raid5d+0x291/0x47c [raid456])
[22404.763959] [<bf871e45>] (raid5d [raid456]) from [<bf809529>]
(md_thread+0xdd/0xfc [md_mod])
[22404.764021] [<bf809529>] (md_thread [md_mod]) from [<c013388d>]
(kthread+0x111/0x124)
[22404.764051] [<c013388d>] (kthread) from [<c0100139>]
(ret_from_fork+0x11/0x38)
[22404.764060] Exception stack(0xc3c93fb0 to 0xc3c93ff8)
[22404.764066] 3fa0:                                     00000000
00000000 00000000 00000000
[22404.764071] 3fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[22404.764076] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[22404.764080] ---[ end trace 12bd672a6d45792f ]--
