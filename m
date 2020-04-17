Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA651ADB24
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 12:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgDQKel (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 06:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728997AbgDQKei (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Apr 2020 06:34:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E890BC061A0F
        for <dmaengine@vger.kernel.org>; Fri, 17 Apr 2020 03:34:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so2502877wrq.2
        for <dmaengine@vger.kernel.org>; Fri, 17 Apr 2020 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=wbl0aeufa/22z2eeBbL/aAsKWxbJHUBJwEkTChBqoAQ=;
        b=DQ7mhfazBsBQ+ES59fgYlEVbYgOFJDUz1grN966rtthpXdE37315Z7k5F6y5Qh9Kld
         ca2tKRYtiHLEuJmoG6hGgWNx3zSICRTcWkETdYVHe1HSmdR7BEG++jgClo2rPj+9Idzz
         2TSbG6TTIlIbAQ9Uv5jEf/Izi83bqKe7icAPQnReB8pruqLDyoDDor6sQk+Ut0Ql+TGB
         BPE0skncSZ1itzyIve7av2UyKtlOUEyBq8lkUbgpGbOwZrr+PHyC5noXDKaufMgRteLu
         H2dCNCJWlOM0+zzOjyO4vvjuXIxMYAzYWin7guLEMWpBEkRNGzQl5a32Es+GoCqlIUwl
         WBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=wbl0aeufa/22z2eeBbL/aAsKWxbJHUBJwEkTChBqoAQ=;
        b=bgju1NjA4LZLbrFx/+kHae34EA/MR2Xq6MY5oaW02lOu+lRWjCYzJLVjitkaJzTnAy
         jUmAqVGXbPqLA3hiBWGCwCOC7+7aM4jN0r7tVHX1Pj0O2ptDgM2U9ly/m8fYGMwq3O8C
         QtsvPhe7Gs4QMTJZamEPenvgkwRRvpTTywqDliBLvho221vgONVW1tBclEifb17X9bgo
         rfXKYBaMsF85b22BwWsWX653Zw/kGUYvLZKQsoeuOH9T6mToXqa8koAQh1FtPtd3K0bB
         eMwUXcxpPeUOLHdXNiilyses3LFURgQ1DtQ7Ed5o8AyITZVuZ4/Q1W6t7OfWdwS078as
         jTJQ==
X-Gm-Message-State: AGi0PuaOU+5s6Vxog3ht0CMnF/OuEcAeicWBjlxsAvwBAWEOPKwjr2S1
        1G1YDhiNAYusgz34wjryU8OuAtkYZZE=
X-Google-Smtp-Source: APiQypJU4mSnTwvo6lfnqIOp31wU50jv2d7MU895Khl/UloSf9oxo+OQ/S3ELnytF3z8glmdHjAGZA==
X-Received: by 2002:adf:f450:: with SMTP id f16mr3183676wrp.346.1587119676323;
        Fri, 17 Apr 2020 03:34:36 -0700 (PDT)
Received: from [192.168.0.26] ([88.125.5.131])
        by smtp.gmail.com with ESMTPSA id f8sm8783057wrm.14.2020.04.17.03.34.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 03:34:35 -0700 (PDT)
To:     alsa-devel@alsa-project.org, dmaengine@vger.kernel.org
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: alsa / dma: Sound stops playing after xrun
Message-ID: <49b8b57c-4e69-6e9e-9bb5-a2ef2df2f258@flowbird.group>
Date:   Fri, 17 Apr 2020 12:34:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi all,

I am seeing a sound problem leading to no more sound after an XRUN .
I see more or less what is happening and have a work around but am not
entirely sure of the correct solution.

The problem occurs on an i.MX6DL using mainline kernel 5.4 with the
fsl_ssi driver and a SGTL5000 audio codec connected over I2S.
The userspace is Android 8 using tinnyhal + tinyalsa.
This uses ioctl to push samples rather than mmap.

The scenario is:
1) A buffer underrun occurs, causing -EPIPE to be returned to userspace.
2) Userpsapce (the tinyalsa component) does a pcm_prepare() to recover 
(which
completes OK).
3) Userspace starts sending data again and then, when the start threshold
is exceeded this kernel log is generated

     fsl-ssi-dai 2028000.ssi: Timeout waiting TX FIFO filling

4) From this point on no more sound is played, further writes timeout
after 10s and return -EIO.

My analsysis is as follows:

When the underrun occurs snd_dmaengine_pcm_trigger(SNDRV_PCM_TRIGGER_STOP)
is performed which does
     dmaengine_terminate_async()

When the stream is restarted 
snd_dmaengine_pcm_trigger(SNDRV_PCM_TRIGGER_START
does
     dmaengine_submit()
     dma_async_issue_pending()

Because dmaengine_terminate_async() is asynchronus it sometimes completes
after the dmaengine_submit(), causing the new DMA request to be cancelled
before it has started.

This results in the "Timeout waiting TX FIFO filling" message (in 
fsl_ssi_config_enable())
because it enables the SSI and expects data to be transfered to the FIFO by
DMA.

The message is only a warning, (void function with no error return)
So without DMA running the buffer quicky fills up, resulting in all future
writes timeouting waiting for buffer space.

Where I'm not sure is if this is an ALSA bug or a bug in the i.MX6 SDMA
controller driver. IE is it OK to do dmaengine_terminate_async() and later
dmaengine_submit() on the same DMA channel without waiting for the
terminate to complete?

My workaround is to wait for the terminate to complete before returning
-EPIPE (just after releasing the lock which prevents sleeping earlier).

Ie this:

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 2236b5e..b03dac3 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -18,6 +18,9 @@
  #include <sound/pcm_params.h>
  #include <sound/timer.h>

+#include <linux/dmaengine.h>
+#include <sound/dmaengine_pcm.h>
+
  #include "pcm_local.h"

  #ifdef CONFIG_SND_PCM_XRUN_DEBUG
@@ -2239,6 +2242,10 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct 
snd_pcm_substream *substream,
                 }
         }
   _end_unlock:
+    /* MF: Workaround for broken sound after XRUN. */
+    if (err == -EPIPE)
+ dmaengine_synchronize(snd_dmaengine_pcm_get_chan(substream));
+
     runtime->twake = 0;
     if (xfer > 0 && err >= 0)
         snd_pcm_update_state(substream, runtime);


Regards,


Martin


