Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8476DFC8E
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDLRSy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 13:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjDLRSx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 13:18:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E63D103;
        Wed, 12 Apr 2023 10:18:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFBAC6127C;
        Wed, 12 Apr 2023 17:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0356C433D2;
        Wed, 12 Apr 2023 17:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681319931;
        bh=nSmtav2rou+Cpt1B2eDZJU6+E8vCA7rDv7cAk9JkOWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtxDuzt5fBIDP/kVJqQoy3wv/iYptqZ4bu65+1AS3454LCbswyjCGf1ehLATlXDJu
         kPQQnh/xgqs2Tg9J2d6KkSHpOeRAcxD9QAVtf05/gNQRZ7IbEL896dLCRt3YPx0+E1
         lDIdRZgaTrejZgSSJqDeWlW/f2TvcAvcIKRGAnpKkXHtWgrKb/IoWrWwTl/10eEr7E
         pyw0tDO12aS2QjElu/P6vlWYbfgOx4RnSK6dKfwbceU0yeN/esPtCAF/SLZHCdyBJI
         4+E2NUBic4wkdvChvMHMgC7ASTLVNyLhRmhry5lZSW79URL39wFTVzCQmSB52sJLiW
         Yx/O2IZYxiwEw==
Date:   Wed, 12 Apr 2023 22:48:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/16] Enable DSA 2.0 Event Log and completion record
 faulting features
Message-ID: <ZDbn9322i2DVpnQs@matsya>
References: <20230407203143.2189681-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407203143.2189681-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-04-23, 13:31, Fenghua Yu wrote:
> Applications can send 64B descriptors to the DSA device via CPU
> instructions MOVDIR64B or ENQCMD. The application can choose to have
> the device write back a completion record (CR) in system memory to
> indicate the status of the descriptor submitted on completion.
> 
> With the DSA hardware, the device is able to do on demand paging through
> the hardware by faulting in the user pages that do not have physical memory
> page backing with assistance from IOMMU. In the spec this was designated as
> the block on fault feature. While this hardware feature made operation
> simpler, it also stalls the device engines while the memory pages are being
> faulted in through Page Request Service (PRS). For applications sharing the
> same workqueue (wq) or wqs in the same group, operations are stalled if
> there are no free engines. To avoid slowing the performance of all other
> running applications sharing the same device engine(s), PRS can to be
> disabled and software can deal with partial completion.
> 
> The block on fault feature on DSA 1.0 can be disabled for the wq. However,
> PRS is not completely disabled for the whole path. It is not disabled for
> CRs or batch list for a batch operation.
> 
> The other issue is the DSA 1.0 error reporting mechanism, SWERROR register.
> The SWERROR register can only report a single error at a time until the
> driver reads and acknowledges the error. The follow on errors cannot be
> reported until the current error is "cleared" by the software by writing
> a bit to the SWERR register. If a large number of faults arrive and the
> software cannot clear them fast enough, overflowed errors will be dropped
> by the device.
> 
> A CR is the optional 32 bytes (DSA) or 64 bytes (IAA) status that is
> written back for a submitted descriptor. If the address for the CR faults,
> the error is reported to the SWERROR register instead.
> 
> With DSA 2.0 hardware [1], the event log feature is added. All errors are
> reported as an entry in a circular buffer reside in the system memory.
> The system admin is responsible to configure the size of the circular
> buffer large enough per device to handle the potential errors that may be
> reported. If the buffer is full and another error needs to be reported,
> the device engine will block until there's a free slot in the buffer.
> An event log entry for a faulted CR will contain the error information,
> the CR address that faulted, and the expected CR content the device had
> originally intended to write.
> 
> DSA 2.0 also introduces per wq PRS disable knob. This will disable all PRS
> operations for the specific wq. The device will still have Address
> Translation Service (ATS) on. When ATS fails on a memory address for a CR,
> an eventlog entry will be written by the hardware into the event log
> ring buffer. The driver software is expected to parse the event log entry,
> fault in the address of the CR, and the write the content of the CR to
> the memory address.
> 
> This patch series will implement the DSA 2 event log support. The support
> for the handling of the faulted user CR is added. The driver is also
> adding the same support for batch operation descriptors. With a batch
> operation the handling of the event log entry is a bit more complex.
> The faulting CR could be for the batch descriptor or any of the operation
> descriptors within the batch. The hardware generates a batch identifier
> that is used by the driver software to correlate the event log entries for
> the relevant descriptors of that batch.
> 
> The faulting of source and destination addresses for the operation is not
> handled by the driver. That is left to be handled by the user application
> by faulting in the memory and re-submit the remaining operation.

Applied, thanks

-- 
~Vinod
