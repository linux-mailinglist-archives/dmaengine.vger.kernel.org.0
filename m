Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7033A707F0F
	for <lists+dmaengine@lfdr.de>; Thu, 18 May 2023 13:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjERLVv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 May 2023 07:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjERLVu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 May 2023 07:21:50 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF43CE;
        Thu, 18 May 2023 04:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684408905; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gFcW7tev1p1xxsHThF0WHWbT4Usis4Pu1Ed7ZHlnvQMrYqCrtHCZT0LLDob+OqmjB5
    zlafA6o3CyPsOszlTjPJhIHP0SA6JLCACkdXFI0OG3A5kIZ4DX1sp/gBnwx8thZMwbhZ
    9CKVCQHRAyFSHRQ0fofQ2LQDkEOztaYnOkLR6mZ6CUxvjl3Uux/KTBwOS7eG8OcZb49R
    9AY+Mhaow8yDE4bCtWFS7U0OvkJ8Ka5TIEKSEKua4sfnTjcCdYiN4zjGdhlvPQq6rupZ
    YFhJ+SPsNUKTkbU316AnJVqOyARuCoqjEgxIzzs24fZR7+zYBPL6sgnEao9mJCr93/Yu
    Mhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684408905;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ju8BKyKY2YxRy4nutIKesIhOE+belF/Bvy4JkS3DQgw=;
    b=f3Py8v5yvFmZS6tXfXE214HBjSpz9kE9XoVd+HdTdJU+DmyMGTFg1O4+/KT+hA6EWA
    4r3tgvYuYZLdUCsFDCw3dWHZWuoal5gSh8iL96fFE7bLtFcwT4ke/qZ4JXJ8+IFAXVRn
    z8OMau9NRjBsO/21UCyCXZxNnHwrNiLoKyM99zL3lzakgADujZwrAgE9/1GIr+vmUiRY
    49a4cL4O3q3r6ZIPTFvJAovqhnIMy85VSqOrshjIRGMiBYOaa7O970hKz4avb3mFpHQh
    4/e89gUsjS2LAl0K4Py9YJY6vOVrpjwqAQPz/OixK7v3SOdn5gMHxbyaewrujiAtJzSw
    T9bA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684408905;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ju8BKyKY2YxRy4nutIKesIhOE+belF/Bvy4JkS3DQgw=;
    b=Xa1R7MtSh/DgBs+Uwek9j317Ubu67yGZSBEQHRPmWzb6s2RoH//u0hm12V4hOqXsge
    R5Z+HUmLZcwrbTCc+j2HVG0wNQ7mqtETjJTJpRfOZZyMiAej6Dgc7IxHPtLo/vy1jc0C
    8sXcn3gy/JJmL0ccTgKuHYwPrTlQjm+i+4bnaEqPS6M2FzG075LXMIQwFRFncWWB+pj2
    FSvMnHbwArTne8W4RhNBASxU1ZCBpPgmISQWej+ZAU1XUR6H/CBAt/LTBS6KkMht67Nj
    a2GVUwV/1CdIce0WrAygPh6IGiq1L++XSRKYW4HLFJ7breR+guUV4ZgK4Cp9cf0vlDij
    uN8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684408905;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ju8BKyKY2YxRy4nutIKesIhOE+belF/Bvy4JkS3DQgw=;
    b=PbcbnpCKxbYJkvm70UIqMy2ruErR7gM6+IwQv1NrWmTbR6JOIBFOlbAdDU6YFh5bCB
    2dVSNjBW4nuAAFaceVAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z2F1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4IBLjCPX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 18 May 2023 13:21:45 +0200 (CEST)
Date:   Thu, 18 May 2023 13:21:38 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: make channels/EEs optional in
 DT with clock
Message-ID: <ZGYKQkgRrBqO2rsx@gerhold.net>
References: <20230518-bamclk-dt-v1-1-82f738c897d9@gerhold.net>
 <CAH=2Ntya7bqHVri_F8BOUJ6kJxtG2_usV08do+=OgkaoVJvxBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2Ntya7bqHVri_F8BOUJ6kJxtG2_usV08do+=OgkaoVJvxBQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 18, 2023 at 04:43:57PM +0530, Bhupesh Sharma wrote:
> On Thu, 18 May 2023 at 14:56, Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > If we have a BAM clock in the DT we are able to turn on the BAM
> > controller while probing, so there is no need to read "num-channels"
> > and "qcom,num-ees" from the DT. It can be read more accurately directly
> > from the identification registers of the BAM.
> >
> > This simplifies setting up typical controlled-remotely BAM DMAs in the
> > DT that can be turned on via a clock (e.g. the BLSP DMA).
> 
> Can you please list which qcom board(s) you tested this patch on?
> 

It works fine at least on MSM8916/DB410c (for blsp_dma) and MDM9607
(blsp_dma and qpic_dma (for NAND)). More testing would be much
appreciated of course!

Personally I don't see much of a risk: If enabling the clock doesn't
actually enable the BAM controller, then the clock probably does not
belong to the BAM in the first place... :)

Thanks,
Stephan
