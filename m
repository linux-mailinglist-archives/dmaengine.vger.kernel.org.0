Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AAF5638C0
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiGARwj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiGARwj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 13:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCCB23AA51
        for <dmaengine@vger.kernel.org>; Fri,  1 Jul 2022 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656697956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67MJyXaDqImTHwnOnH/GBMo2aZ3gIWFmeSkeeeT9284=;
        b=dE6AyjtiQ1L2nPRgOgMpJ7gZgGSEKtloGwYpabyLng7ZFVSMWfRKqOGTlNSbkPnOB2677w
        OfsbfzHjdJKCl4INLNYX1a0/yN+oTG/ewvQVL2YwY8P5T6xEUe26e94qqI2wBhzhzB/wiT
        3BwuqbQGdJsbB0KS/PoqPel0UOHY6G8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177--0GLrMDWPe-uefw86cOw0w-1; Fri, 01 Jul 2022 13:52:35 -0400
X-MC-Unique: -0GLrMDWPe-uefw86cOw0w-1
Received: by mail-pl1-f198.google.com with SMTP id o9-20020a170902d4c900b0016a629e2f1bso1739262plg.20
        for <dmaengine@vger.kernel.org>; Fri, 01 Jul 2022 10:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=67MJyXaDqImTHwnOnH/GBMo2aZ3gIWFmeSkeeeT9284=;
        b=bzwcx1JwnEaMeXNTcxX8AtQofi6/9xYy+v7bmxpoAjq1wpeC/pXk2a70J6MMHc941v
         xJjef/ijP3YumEadHOoQYiphbJ83OHfCu+sl7V4Rfa1ti58sr0cr7Vl9pSs3EvJ90Lv/
         rSKWj0h1xueTWHc3PtIPZF63yLHIMu1S3EAsJDBInlnBHnVWBpSMIfTyx7wToEgXIjjr
         pYP4orUmA+XzJsNEZwJXavot5BC8se4h+DBlq6Tmvd05EhZQ3vzamMb7Xf0WrO+wbF7d
         pJlTIdracSAFJUAcxPnfimixb4F7pB5tuyDG51oBCqpcNI5y/tr6IkFYK4CoGP8FH4C8
         EWNw==
X-Gm-Message-State: AJIora8dFhUj7qbzDUCp/2IBm5Hnq3tA268r7ia6Mb4zeLIE2rXSY7qw
        a7Ui4BWqyr20+dUB+2sKxIyMZe7z1EPEFxzbNDhmHRNwO7zXj4800VGeEExCzyGmdsx1vLN4X8D
        Eea2ByMpEBrcaVpO4qxhD
X-Received: by 2002:a63:1809:0:b0:408:417a:6fa5 with SMTP id y9-20020a631809000000b00408417a6fa5mr13486187pgl.228.1656697954699;
        Fri, 01 Jul 2022 10:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tiyDKemehCIPbCYtSalbzT9O2Eo+2uaZrA4LQQS6N4cxzBFgMrJZFlFqYmEd/iyq0Cd64CEA==
X-Received: by 2002:a63:1809:0:b0:408:417a:6fa5 with SMTP id y9-20020a631809000000b00408417a6fa5mr13486167pgl.228.1656697954439;
        Fri, 01 Jul 2022 10:52:34 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709026b8500b00163fbb1eec5sm15712052plk.229.2022.07.01.10.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 10:52:33 -0700 (PDT)
Date:   Fri, 1 Jul 2022 10:52:32 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3] dmaengine: idxd: Only call idxd_enable_system_pasid()
 if succeeded in enabling SVA feature
Message-ID: <20220701175232.e27zznvohnkzvjdq@cantor>
References: <20220625221333.214589-1-jsnitsel@redhat.com>
 <20220626051648.14249-1-jsnitsel@redhat.com>
 <YrfwaC06wZfUTHjH@fyu1.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrfwaC06wZfUTHjH@fyu1.sc.intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jun 25, 2022 at 10:36:40PM -0700, Fenghua Yu wrote:
> On Sat, Jun 25, 2022 at 10:16:48PM -0700, Jerry Snitselaar wrote:
> > On a Sapphire Rapids system if boot without intel_iommu=on, the IDXD
> > driver will crash during probe in iommu_sva_bind_device().
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> Acked-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Thanks.
> 
> -Fenghua

Hi Vinod,

Should this get pulled into your fixes branch?

Regards,
Jerry

