Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD18705BE3
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 02:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEQATp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 20:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEQATo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 20:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0E2129
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684282734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAWA1BLnS6OZoKpUWNVEQYD1QFUo+cJ+dgpIwEFG8vQ=;
        b=MyKNlXGC4lLrsgqQZYBSCeq2R2EJhlFeyansotgpO/+ZclrpYBkaDI37GGK9doMDSe/1y/
        f1pFHuluczWb8GWyBAQuVluCnMXMH0JC8k48ONbygBT39+5XFPjbfnSxAyjBAf4NpEvlWx
        zFPPjG3G/kE2lNOhp0hVuCZMe/dcU00=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-xSYMGA7rM6C5pLqfMBrTEw-1; Tue, 16 May 2023 20:18:51 -0400
X-MC-Unique: xSYMGA7rM6C5pLqfMBrTEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3A533810B05;
        Wed, 17 May 2023 00:18:50 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02B2A1410DD5;
        Wed, 17 May 2023 00:18:49 +0000 (UTC)
Date:   Wed, 17 May 2023 08:18:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] dmaengine: make QCOM_HIDMA depend on HAS_IOMEM
Message-ID: <ZGQdZhutT+lUdily@MiWiFi-R3L-srv>
References: <20230506111628.712316-1-bhe@redhat.com>
 <20230506111628.712316-3-bhe@redhat.com>
 <ZGPD1wELeXafPJ/T@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGPD1wELeXafPJ/T@matsya>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05/16/23 at 11:26pm, Vinod Koul wrote:
> On 06-05-23, 19:16, Baoquan He wrote:
> > On s390 systems (aka mainframes), it has classic channel devices for
> > networking and permanent storage that are currently even more common
> > than PCI devices. Hence it could have a fully functional s390 kernel
> > with CONFIG_PCI=n, then the relevant iomem mapping functions
> > [including ioremap(), devm_ioremap(), etc.] are not available.
> > 
> > Here let QCOM_HIDMA depend on HAS_IOMEM so that it won't be built to
> > cause below compiling error if PCI is unset.
> 
> I have 2/2 patch here, where is patch 1 of 2..?

It's here, thanks for check.
https://lore.kernel.org/all/20230506111628.712316-2-bhe@redhat.com/T/#u

I used get_maintainer to get reivewers list, seems your contact is only
put in 2/2 patch. I also sent to lkml, linux-mm and s390 mailing list,
so the whole series can be seen in any of the ML.

Thanks
Baoquan

> 
> > 
> > --------------------------------------------------------
> > ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
> > hidma.c:(.text+0x4b46): undefined reference to `devm_ioremap_resource'
> > ld: hidma.c:(.text+0x4b9e): undefined reference to `devm_ioremap_resource'
> > make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
> > make: *** [Makefile:1264: vmlinux] Error 2
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: dmaengine@vger.kernel.org
> > ---
> >  drivers/dma/qcom/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
> > index 3f926a653bd8..ace75d7b835a 100644
> > --- a/drivers/dma/qcom/Kconfig
> > +++ b/drivers/dma/qcom/Kconfig
> > @@ -45,6 +45,7 @@ config QCOM_HIDMA_MGMT
> >  
> >  config QCOM_HIDMA
> >  	tristate "Qualcomm Technologies HIDMA Channel support"
> > +	depends on HAS_IOMEM
> >  	select DMA_ENGINE
> >  	help
> >  	  Enable support for the Qualcomm Technologies HIDMA controller.
> > -- 
> > 2.34.1
> 
> -- 
> ~Vinod
> 

