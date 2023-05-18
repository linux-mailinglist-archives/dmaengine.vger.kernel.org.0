Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB8707F5B
	for <lists+dmaengine@lfdr.de>; Thu, 18 May 2023 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjERLch (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 May 2023 07:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjERLcd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 May 2023 07:32:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AE519B5;
        Thu, 18 May 2023 04:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4357764E74;
        Thu, 18 May 2023 11:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12784C4339C;
        Thu, 18 May 2023 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684409544;
        bh=tPMpgzLhB4+qp6UqQL+xY8X4kJc3RZ//RIRZC7aBtTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=abiXFU3kXY3gNtksbgeKZF9niDk+C+FEfaDtZVhv49+jRuTzL+oOWbuJjwgPBTyez
         T3QZmNgW1Cr/6fppRiRKuz6rGZlBhX8icz3DUF5QXvvcmfB9c7CxFpMNH3AvW6zjS1
         Ims9EEDnyopqiZUhsvUnfQgrrph5dq4PJY0zJD9IVlcwot80L+V3d489IeCs7SGHCe
         eguaZ3j10VSgqle5VBR7+TPjIXxiMKx4HqwHDKFEJtwWTluKzbI2W43zPe+1YAAacY
         AuBfVtjL0+qkGJzgV3XCuUJsBjy2pka1EGxy1+J6QIzGL0Lf2r61fMEOOti/Ht4lI1
         w1CmjO5tZrgIA==
Date:   Thu, 18 May 2023 17:02:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] dmaengine: make QCOM_HIDMA depend on HAS_IOMEM
Message-ID: <ZGYMxNCpACqT2nZ3@matsya>
References: <20230506111628.712316-1-bhe@redhat.com>
 <20230506111628.712316-3-bhe@redhat.com>
 <ZGPD1wELeXafPJ/T@matsya>
 <ZGQdZhutT+lUdily@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGQdZhutT+lUdily@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-05-23, 08:18, Baoquan He wrote:
> On 05/16/23 at 11:26pm, Vinod Koul wrote:
> > On 06-05-23, 19:16, Baoquan He wrote:
> > > On s390 systems (aka mainframes), it has classic channel devices for
> > > networking and permanent storage that are currently even more common
> > > than PCI devices. Hence it could have a fully functional s390 kernel
> > > with CONFIG_PCI=n, then the relevant iomem mapping functions
> > > [including ioremap(), devm_ioremap(), etc.] are not available.
> > > 
> > > Here let QCOM_HIDMA depend on HAS_IOMEM so that it won't be built to
> > > cause below compiling error if PCI is unset.
> > 
> > I have 2/2 patch here, where is patch 1 of 2..?
> 
> It's here, thanks for check.
> https://lore.kernel.org/all/20230506111628.712316-2-bhe@redhat.com/T/#u
> 
> I used get_maintainer to get reivewers list, seems your contact is only
> put in 2/2 patch. I also sent to lkml, linux-mm and s390 mailing list,
> so the whole series can be seen in any of the ML.

Ideally these two could have been sent separately! If sending together
add a cover and cc everyone, so that we know..

Applied now

-- 
~Vinod
