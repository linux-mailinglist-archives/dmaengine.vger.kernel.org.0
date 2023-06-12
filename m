Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5179B72BD26
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjFLJzR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFLJyR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6347649F6;
        Mon, 12 Jun 2023 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VyS6fqYhD/n91U5f9GQ+a8R8fakG8EouUVHj8V9PE00=; b=QruMXFdvJIpT6C4xhfbtXQc4F6
        4BWAt2iZpXnuR4PZL/DqfGiytuUGSiJSOq/8VdBO2EL0m6XzvNtDiKZ1oLWkBo4Fjyp1SCW0HtowW
        khBwKdFSkOaLE0NRU0h6wppJ/BJQbx6t+fi0YMOq8E+vtMHdfs8eGLnlXdcKkdtjJW1TZjuaLEaOi
        xRrHYrmW0sm1wBcbePBmYSzXufFebgerY8jxwNA5ArsNL9JCWj7MuCccd5YfoqES1HrUtarXWvNv9
        rTToGRe669jagMzznnXleX7c296r5JI6WREQfZY9f/DB2/IM2B7t9lrQeaDhqxwYfXOZ/h3jaM8KO
        MM3mvBbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0f-008kOm-0u;
        Mon, 12 Jun 2023 09:38:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29BC6300E86;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ED20B240FDF93; Mon, 12 Jun 2023 11:38:47 +0200 (CEST)
Message-ID: <20230612093537.467120754@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Subject: [PATCH v3 01/57] dmaengine: ioat: Free up __cleanup() name
References: <20230612090713.652690195@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In order to use __cleanup for __attribute__((__cleanup__(func))) the
name must not be used for anything else. Avoid the conflict.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/dma/ioat/dma.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -584,11 +584,11 @@ desc_get_errstat(struct ioatdma_chan *io
 }
 
 /**
- * __cleanup - reclaim used descriptors
+ * __ioat_cleanup - reclaim used descriptors
  * @ioat_chan: channel (ring) to clean
  * @phys_complete: zeroed (or not) completion address (from status)
  */
-static void __cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
+static void __ioat_cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
 {
 	struct ioatdma_device *ioat_dma = ioat_chan->ioat_dma;
 	struct ioat_ring_ent *desc;
@@ -675,7 +675,7 @@ static void ioat_cleanup(struct ioatdma_
 	spin_lock_bh(&ioat_chan->cleanup_lock);
 
 	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 
 	if (is_ioat_halted(*ioat_chan->completion)) {
 		u32 chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
@@ -712,7 +712,7 @@ static void ioat_restart_channel(struct
 
 	ioat_quiesce(ioat_chan, 0);
 	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 
 	__ioat_restart_chan(ioat_chan);
 }
@@ -786,7 +786,7 @@ static void ioat_eh(struct ioatdma_chan
 
 	/* cleanup so tail points to descriptor that caused the error */
 	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 
 	chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
 	pci_read_config_dword(pdev, IOAT_PCI_CHANERR_INT_OFFSET, &chanerr_int);
@@ -943,7 +943,7 @@ void ioat_timer_event(struct timer_list
 		/* timer restarted in ioat_cleanup_preamble
 		 * and IOAT_COMPLETION_ACK cleared
 		 */
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 		goto unlock_out;
 	}
 


