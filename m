Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99DF7D6215
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 09:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjJYHHI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 03:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYHHH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 03:07:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8875CDD
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 00:07:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32dc918d454so3382053f8f.2
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 00:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698217624; x=1698822424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F9y5xYJB0io3mRJrUc/0FkGqa7RrEdlAEtFuIgcZZVQ=;
        b=Lpx1smO86zS+ruNxxQ/VMZh1BMqXgixfO5Wxh+Y/vxLf1rz8J88UfE1Qp+O2T6T2uU
         c0Lq4Bg7Eoxb/0VP22BbrrCmIN7z5r2zQkBwmRdyFSVOy8msqS/2/qLAQ1q0gmsJT5/k
         rPxhPJ0S8XC7uIrGSscT2wmqgvC0K3dsh9iEI0Yna8+zWEKkOItuS62T3+a45wp0VJ5U
         riuQ/0Vp3jY/zruIMWisf1wrHdNIRZhts5LEBSiBUhmTPNNmnfLSXYvKA+ZEU1KQ3tme
         M+jmr0j3qJhCVUvDohBWewKda7Opp4JwEXunqgolNqtY3N+VxPy/CrH4w5oGM2aByxDc
         T18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698217624; x=1698822424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9y5xYJB0io3mRJrUc/0FkGqa7RrEdlAEtFuIgcZZVQ=;
        b=VI/7bwY2SCJERn8DxEDVzb+JoLdZKt+IB8oGrfZtrSuMRVIti8Wq0QfMDzkhIX3PVM
         H2Tg7/Q5WpRCh2eTzjuiyHkOCzGUo07CYvVoOFnc1na3Pd6rRyQQUwqpKmIxRha6UiM5
         7PjVA5E+6rh1ha3J15RIeeLDNWwx1NpC7wyLZ0ysWSAYCDsl/ScvxaJylfN5vXl9Rr49
         xULpi6b1C7P6w2USv7rDf09ueq/bmfVvq6Ft+OczZYUqkwsYfq2ZNbcD3XWZrrEP1P97
         1MXfdwxRlPZYfIybT6RN5iHlZUuZXnGQzMWxRIFsS/GNd38jq1nNeAzL4KNqGEKY7TNi
         MfyQ==
X-Gm-Message-State: AOJu0YyG5kEyfFdfo23ePRkmF6txrdGCAMigHGteJhb43E/sumLLLSYW
        BZ+kfNhDfyQMrM2u3BvypYtHYQ==
X-Google-Smtp-Source: AGHT+IEpX6UdKN7Bif3mppqkWoE/HLm44z1lSiDEQdOpxke1PbZnv2rsGblEhtuSfvVBWpZOAHUJnA==
X-Received: by 2002:adf:fd91:0:b0:31f:e5cf:6724 with SMTP id d17-20020adffd91000000b0031fe5cf6724mr10161138wrr.46.1698217623977;
        Wed, 25 Oct 2023 00:07:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id dj18-20020a0560000b1200b0032d96dd703bsm11470892wrb.70.2023.10.25.00.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:07:03 -0700 (PDT)
Date:   Wed, 25 Oct 2023 10:07:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     Wenchao Hao <haowenchao22@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        dmaengine@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: scsi_debug: fix some bugs in
 sdebug_error_write()
Message-ID: <9207ed62-4e41-4b8c-8aee-5143c1a71bf8@kadam.mountain>
References: <96d50cf7-afec-46af-9d98-08099f8dc76e@moroto.mountain>
 <CAOptpSMTgGwyFkn8o6qAEnUKXh+_mOr8dQKAZUWfM_4QEnxzxw@mail.gmail.com>
 <44b0eca3-57c1-4edd-ab35-c389dc976273@kadam.mountain>
 <cbe14e3a-11c7-4da5-b125-5801244e27f2@gmail.com>
 <9767953c-480d-4ad9-a553-a45ae80c572b@kadam.mountain>
 <afe1eca8-cdf8-612b-867e-4fef50ad423f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afe1eca8-cdf8-612b-867e-4fef50ad423f@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 25, 2023 at 02:10:41PM +0800, Wenchao Hao wrote:
> On 2023/10/25 12:11, Dan Carpenter wrote:
> > On Wed, Oct 25, 2023 at 01:09:34AM +0800, Wenchao Hao wrote:
> > > Yes, there is bug here if write with .c code. Because your change to use
> > > strndup_user() would make write with dirty data appended to "ubuf" failed,
> > 
> > I don't understand this sentence.  What is "dirty" data in this context?
> > 
> 
> This is what I posted in previous reply:
> 
> We might have following pairs of parameters for sdebug_error_write:
> 
> ubuf: "0 -10 0x12\n0 0 0x2 0x6 0x4 0x2"
> count=11
> 
> the valid data in ubuf is "0 -10 -x12\n", others are dirty data.
> strndup_user() would return EINVAL for this pair which caused
> a correct write to fail.

I mean, I could just tell you that your kzalloc(count + 1, GFP_KERNEL)
fix will work.  It does work.

But how is passing "dirty data" a "correct write"?  I feel like it
should be treated as incorrect and returning -EINVAL is the correct
behavior.  I'm so confused.  Why are users doing that?

I have looked at the code and it just doesn't seem that complicated.
They shouldn't be passing messed up strings and expect the kernel to
allow it.

regards,
dan carpenter

