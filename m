Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8B876BCBC
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjHASoo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHASon (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8317B0;
        Tue,  1 Aug 2023 11:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7966D61690;
        Tue,  1 Aug 2023 18:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D15C433C7;
        Tue,  1 Aug 2023 18:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915481;
        bh=xbrjg3J44rv0v2tdlM2UYtQaC5LkH85rtfLJlA9ixO4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bRi24AO05Bzc5k+LUf/yeTVymvK0WptBnIHYg68MlDru1jGNoQ7HDdsqc9ZADTAsI
         3mhNhQuQCTiMNwwl3U4KZTxjsZ138v21Rmcs2hKsg/hqHlC6FodhsyVrW8Y0A/xsCu
         VQ+VVJCakpOpAiaPIhKWr03pFOIzE+GDExn7IpHZqZgO+1MRFLtosed1nBp8C/BfV/
         2ArkF7ZMyYtxZCmTQSwy0jBRj10F41NvvhOdm07/I9XykdFIPXS4La3MkTQKj4rY+t
         WG0bA1AbmXlb/0YRkawAN75wjgmZHiIQZQT4V4R2+rh6DWkJ6SEw/YPYBPZCQCVB2Q
         Iq4lx+pa9fbtg==
From:   Vinod Koul <vkoul@kernel.org>
To:     okaya@kernel.org, andersson@kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20230707195003.6619-1-quic_jhugo@quicinc.com>
References: <20230707195003.6619-1-quic_jhugo@quicinc.com>
Subject: Re: [PATCH] dmaengine: qcom_hidma: Update codeaurora email domain
Message-Id: <169091547956.69326.1696848724995189371.b4-ty@kernel.org>
Date:   Wed, 02 Aug 2023 00:14:39 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Fri, 07 Jul 2023 13:50:03 -0600, Jeffrey Hugo wrote:
> The codeaurora.org email domain is defunct and will bounce.
> 
> Update entries to Sinan's kernel.org address which is the address in
> MAINTAINERS for this component.
> 
> 

Applied, thanks!

[1/1] dmaengine: qcom_hidma: Update codeaurora email domain
      commit: a599486a09b8c763b857344b3f8de2aadb460677

Best regards,
-- 
~Vinod


