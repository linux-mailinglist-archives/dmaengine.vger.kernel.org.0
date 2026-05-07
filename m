Return-Path: <dmaengine+bounces-10256-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM70Bphh/Gm7OwAAu9opvQ
	(envelope-from <dmaengine+bounces-10256-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 11:55:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 807164E64FD
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 11:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0386130128E0
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAAC3CBE78;
	Thu,  7 May 2026 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0eDM5N7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003A3CAE8F;
	Thu,  7 May 2026 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147727; cv=none; b=jqeMRbEX0Weuh/UIfhLxP4P3EXz7wVWyrb15FHA1zyCwAoV8JFy55VL+PCGpMbb2Q5C4TfpWoNYt1HZ7POx8/GLaYX7dtXfGS3lF6BZ/NHE/ocdv+czNueSroKFXQWsnGc04o1ru2MMT4e25ZX7k6JTTZ+8XAUhoMyECzbsRdEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147727; c=relaxed/simple;
	bh=6f4IUJ1E4ztQUpHbwhPfFSRZ/AcEMsNKjRAB71LwAPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COm3lhClvXPOWUvS/BfP8HNmnnfs56/akZg6iBwx+ZZy8SlF4EF3lB2/FmgQ7ygwjGRSWT8XRrmMRnaHoV91zjvBIazN+MV3VtIiK4AOJOi9PZ15TKxcPHey1CsDGfYmm2mr22Szre4Ru64c6vYHdzqUDFAA98V7vNr0mt3dWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0eDM5N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C6DC2BCB2;
	Thu,  7 May 2026 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778147726;
	bh=6f4IUJ1E4ztQUpHbwhPfFSRZ/AcEMsNKjRAB71LwAPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0eDM5N7LxyU5Wd+zRdrf12o7vwrbTAgQ011HoxS4viScLV1BEvFLDiwrlnntC/3i
	 VWdDQ3lUXRCEKECz+OurDuShpuY2jjTg1Vou9xLUfcMKSjHEVHLozO95Q8G1eOiNCj
	 d38kS9D5g9H5T2wyWKw3uA8UBxR9Dlv+JXrQKdLJFo5Un66oQHo3Ui5BRxvwTFbc2P
	 Ml/5TzdI+DQ5l3md01wyXdAYHK3j2GSmo4LJHkaVu6xHn/EiII+vuGYmaaFycSzqN8
	 9WazOB9Kfnsbgf/kzeYwR1nUCgUCJhcXedv5aCN+CEXQpBFs9zQlvLQnD2du80HcZk
	 75H3pWmR5wxzA==
Date: Thu, 7 May 2026 15:25:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Peter Ujfalusi <peter.ujfalusi@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, brgl@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v16 00/12] crypto/dmaengine: qce: introduce BAM locking
 and use DMA for register I/O
Message-ID: <ditrkd5jcxlx7onykxh6n3qhyoclfngmpp277y4t4qwc4vswoo@5os4o5lumidn>
References: <20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com>
X-Rspamd-Queue-Id: 807164E64FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10256-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,vger.kernel.org,lists.infradead.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, Apr 27, 2026 at 11:15:33AM +0200, Bartosz Golaszewski wrote:
> This missed the v7.1 cycle so let's try to get it in for v7.2.
> 
> Merging strategy: there are build-time dependencies between the crypto
> and DMA patches so the best approach is for Vinod to create an immutable
> branch with the DMA part pulled in by the crypto tree.
> 
> This iteration continues to build on top of v12 but uses the BAM's NWD
> bit on data descriptors as suggested by Stephan. To that end, there are
> some more changes like reversing the order of command and data
> descriptors queuedy by the QCE driver.
> 
> Currently the QCE crypto driver accesses the crypto engine registers
> directly via CPU. Trust Zone may perform crypto operations simultaneously
> resulting in a race condition. To remedy that, let's introduce support
> for BAM locking/unlocking to the driver. The BAM driver will now wrap
> any existing issued descriptor chains with additional descriptors
> performing the locking when the client starts the transaction
> (dmaengine_issue_pending()). The client wanting to profit from locking
> needs to switch to performing register I/O over DMA and communicate the
> address to which to perform the dummy writes via a call to
> dmaengine_desc_attach_metadata().
> 
> In the specific case of the BAM DMA this translates to sending command
> descriptors performing dummy writes with the relevant flags set. The BAM
> will then lock all other pipes not related to the current pipe group, and
> keep handling the current pipe only until it sees the the unlock bit.
> 
> In order for the locking to work correctly, we also need to switch to
> using DMA for all register I/O.
> 
> On top of this, the series contains some additional tweaks and
> refactoring.
> 
> The goal of this is not to improve the performance but to prepare the
> driver for supporting decryption into secure buffers in the future.
> 
> Tested with tcrypt.ko, kcapi and cryptsetup.
> 
> Shout out to Daniel and Udit from Qualcomm for helping me out with some
> DMA issues we encountered.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

For the whole series,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks for incorporating all the comments, Bart!

- Mani

> ---
> Changes in v16:
> - Fix a reported race between dma_map_sg() called with spinlock taken
>   and the corresponding dma_unmap_sg() called without it by moving the
>   descriptor locking data into the descriptor struct
> - Also queue the TX data descriptors before the command descriptors to
>   match what downstream is doing
> - Tweak commit messages
> - Rebase on top of v7.1-rc1
> - Link to v15: https://patch.msgid.link/20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com
> 
> Changes in v15:
> - Extend the descriptor metadata struct to also carry the channel's
>   transfer direction and stop using dmaengine_slave_config() for that
> - Link to v14: https://patch.msgid.link/20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com
> 
> Changes in v14:
> - Don't return an error to a client which wants to use locking on BAM
>   that doesn't support it
> - Add a comment describing the DMA descriptor metadata structure
> - Fix memory leaks
> - Remove leftovers from previous iterations
> - Propagate errors from dma_cookie_assign() when setting up lock
>   descriptors
> - Link to v13: https://patch.msgid.link/20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com
> 
> Changes in v13:
> - As part of the DMA changes in the QCE driver: reverse the order of
>   queueing the descriptors in the QCE driver: queue command descriptors
>   with all the register writes first, followed by all the data descriptors,
>   this is in line with the recommandations from the BAM HPG
> - Set the NWD (notify-when-done) bit (DMA_PREP_FENCE in dmaengine
>   parlance) on the data descriptors to ensure that the UNLOCK descriptor
>   will not be processed until after they have been processed by the
>   engine. While technically the NWD bit is only needed on the final data
>   descriptor, it's hard to tell which one *will* be the last from the
>   driver's point-of-view and both the downstream driver as well as
>   the Qualcomm TZ against which we want to synchronize sets NWD on every
>   data descriptor,
> - Revert to creating the LOCK/UNLOCK command descriptor pair in one
>   place now that the NWD bit is in place,
> - Link to v12: https://patch.msgid.link/20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com
> 
> Changes in v12:
> - Wait until the transaction is done before queueing the UNLOCK command
>   descriptor
> - Use descriptor metadata for communicating the scratchpad address to
>   the BAM driver
> - To that end: reverse the order of the series (first BAM, then QCE) to
>   maintain bisectability
> - Unmap buffers used for dummy writes after the transaction
> - Link to v11: https://patch.msgid.link/20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com
> 
> Changes in v11:
> - Use new approach, not requiring the client to be involved in locking.
> - Add a patch constifying dma_descriptor_metadata_ops
> - Rebase on top of v7.0-rc1
> - Link to v10: https://lore.kernel.org/r/20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com
> 
> Changes in v10:
> - Move DESC_FLAG_(UN)LOCK BIT definitions from patch 2 to 3
> - Add a patch constifying the dma engine metadata as the first in the
>   series
> - Use the VERSION register for dummy lock/unlock writes
> - Link to v9: https://lore.kernel.org/r/20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org
> 
> Changes in v9:
> - Drop the global, generic LOCK/UNLOCK flags and instead use DMA
>   descriptor metadata ops to pass BAM-specific information from the QCE
>   to the DMA engine
> - Link to v8: https://lore.kernel.org/r/20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org
> 
> Changes in v8:
> - Rework the command descriptor logic and drop a lot of unneeded code
> - Use the physical address for BAM command descriptor access, not the
>   mapped DMA address
> - Fix the problems with iommu faults on newer platforms
> - Generalize the LOCK/UNLOCK flags in dmaengine and reword the docs and
>   commit messages
> - Make the BAM locking logic stricter in the DMA engine driver
> - Add some additional minor QCE driver refactoring changes to the series
> - Lots of small reworks and tweaks to rebase on current mainline and fix
>   previous issues
> - Link to v7: https://lore.kernel.org/all/20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org/
> 
> Changes in v7:
> - remove unused code: writing to multiple registers was not used in v6,
>   neither were the functions for reading registers over BAM DMA-
> - remove
> - don't read the SW_VERSION register needlessly in the BAM driver,
>   instead: encode the information on whether the IP supports BAM locking
>   in device match data
> - shrink code where possible with logic modifications (for instance:
>   change the implementation of qce_write() instead of replacing it
>   everywhere with a new symbol)
> - remove duplicated error messages
> - rework commit messages
> - a lot of shuffling code around for easier review and a more
>   streamlined series
> - Link to v6: https://lore.kernel.org/all/20250115103004.3350561-1-quic_mdalam@quicinc.com/
> 
> Changes in v6:
> - change "BAM" to "DMA"
> - Ensured this series is compilable with the current Linux-next tip of
>   the tree (TOT).
> 
> Changes in v5:
> - Added DMA_PREP_LOCK and DMA_PREP_UNLOCK flag support in separate patch
> - Removed DMA_PREP_LOCK & DMA_PREP_UNLOCK flag
> - Added FIELD_GET and GENMASK macro to extract major and minor version
> 
> Changes in v4:
> - Added feature description and test hardware
>   with test command
> - Fixed patch version numbering
> - Dropped dt-binding patch
> - Dropped device tree changes
> - Added BAM_SW_VERSION register read
> - Handled the error path for the api dma_map_resource()
>   in probe
> - updated the commit messages for batter redability
> - Squash the change where qce_bam_acquire_lock() and
>   qce_bam_release_lock() api got introduce to the change where
>   the lock/unlock flag get introced
> - changed cover letter subject heading to
>   "dmaengine: qcom: bam_dma: add cmd descriptor support"
> - Added the very initial post for BAM lock/unlock patch link
>   as v1 to track this feature
> 
> Changes in v3:
> - https://lore.kernel.org/lkml/183d4f5e-e00a-8ef6-a589-f5704bc83d4a@quicinc.com/
> - Addressed all the comments from v2
> - Added the dt-binding
> - Fix alignment issue
> - Removed type casting from qce_write_reg_dma()
>   and qce_read_reg_dma()
> - Removed qce_bam_txn = dma->qce_bam_txn; line from
>   qce_alloc_bam_txn() api and directly returning
>   dma->qce_bam_txn
> 
> Changes in v2:
> - https://lore.kernel.org/lkml/20231214114239.2635325-1-quic_mdalam@quicinc.com/
> - Initial set of patches for cmd descriptor support
> - Add client driver to use BAM lock/unlock feature
> - Added register read/write via BAM in QCE Crypto driver
>   to use BAM lock/unlock feature
> 
> ---
> Bartosz Golaszewski (12):
>       dmaengine: constify struct dma_descriptor_metadata_ops
>       dmaengine: qcom: bam_dma: convert tasklet to a BH workqueue
>       dmaengine: qcom: bam_dma: Extend the driver's device match data
>       dmaengine: qcom: bam_dma: Add pipe_lock_supported flag support
>       dmaengine: qcom: bam_dma: add support for BAM locking
>       crypto: qce - Include algapi.h in the core.h header
>       crypto: qce - Remove unused ignore_buf
>       crypto: qce - Simplify arguments of devm_qce_dma_request()
>       crypto: qce - Use existing devres APIs in devm_qce_dma_request()
>       crypto: qce - Map crypto memory for DMA
>       crypto: qce - Add BAM DMA support for crypto register I/O
>       crypto: qce - Communicate the base physical address to the dmaengine
> 
>  drivers/crypto/qce/aead.c        |   8 +-
>  drivers/crypto/qce/common.c      |  20 ++--
>  drivers/crypto/qce/core.c        |  28 ++++-
>  drivers/crypto/qce/core.h        |  11 ++
>  drivers/crypto/qce/dma.c         | 163 +++++++++++++++++++++++------
>  drivers/crypto/qce/dma.h         |  11 +-
>  drivers/crypto/qce/sha.c         |   8 +-
>  drivers/crypto/qce/skcipher.c    |   8 +-
>  drivers/dma/qcom/bam_dma.c       | 217 ++++++++++++++++++++++++++++++++++-----
>  drivers/dma/ti/k3-udma.c         |   2 +-
>  drivers/dma/xilinx/xilinx_dma.c  |   2 +-
>  include/linux/dma/qcom_bam_dma.h |  14 +++
>  include/linux/dmaengine.h        |   2 +-
>  13 files changed, 404 insertions(+), 90 deletions(-)
> ---
> base-commit: 06ae5ec2a5f35da6b24d404d16310ee3553dba6f
> change-id: 20251103-qcom-qce-cmd-descr-c5e9b11fe609
> 
> Best regards,
> -- 
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

