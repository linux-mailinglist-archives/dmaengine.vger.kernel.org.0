Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C21B7D60CF
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 06:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjJYESe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 00:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjJYESc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 00:18:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59082134
        for <dmaengine@vger.kernel.org>; Tue, 24 Oct 2023 21:18:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40838915cecso42732425e9.2
        for <dmaengine@vger.kernel.org>; Tue, 24 Oct 2023 21:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698207508; x=1698812308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNR7ea//1RhQMh43Nn1LOqMDgljHo5DtbTVWYpA0DcM=;
        b=ko9Ir6CpWZ+1p4uRxfMW2laYWn1bIFDmU44AwsklfHpf80B9uJtZfEU5imcIXl7bcx
         KiBX97ZdFAebrAtW4ui+7tWLxeJNpFcQeu9W6PS0DYIyFmS2lKvBR8mVc02O5YjWeIqz
         /xqIIg/9jE4HJircGcnUCyMwFJQf0jofy9XS8gDqwvoW5TjzckDXaWBlX7MkNOIhyfCO
         ht/e4S4HP0BXgr5qRP2NuwMVkojnUEybiL0eku7VOaDY+H5tRva5fgIJtz3vCXZBnibV
         sl7BdTqLbWbqld+rtEGqx5dF/H//hmZEPnUP8LrscCd6E/MpobCyDcTTbp6d8Ya3oTtA
         GZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698207508; x=1698812308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNR7ea//1RhQMh43Nn1LOqMDgljHo5DtbTVWYpA0DcM=;
        b=IWH4jp87wWiO1DC9C8E6KKY45pXZkHevZvfHpfcA0BoWUuMg8M04vKlfMPOM1iPKAT
         XxqgaeDCv7O4GLaXcEHLrcJqFd793vk0CgfWCWgFqYBVM7/8j7UQab4thJzjLlkzuGLV
         eCHtOPLm3bZFWEE1qQZRYW1CVoHpuuxi44fqVfg6Yp/6TIRIDFfzh7JlASk8kVp55gDy
         yZ02e9xNqsbZqhSZHMS/wq5PsMV/rNpoNEzFQn6QYjIHkIHkYHMVneOj1I/0ELAqkhE+
         NaoyetypRud5/QCohblALkLK4BmrFl5pMePbvchj2me4KT41v+BrKC2nGUVAH1qQdRgS
         R4CA==
X-Gm-Message-State: AOJu0Yw9azuLRCCdePItNJIe6cibIqG6IqwwRSz7FjHBEtOyNU/uliX9
        Q355OJeYbtGwBYX2w3Q27ErEJ/6sMR95ahng/kM=
X-Google-Smtp-Source: AGHT+IHh0Yz93NJIxzr1UvkVjXqIOZmuaG6avCJrJHwpf93+day3qOWd2OD7YLuO2MBZGqUL+ayLdg==
X-Received: by 2002:a05:600c:19d1:b0:405:82c0:d9d9 with SMTP id u17-20020a05600c19d100b0040582c0d9d9mr10694503wmq.41.1698207507203;
        Tue, 24 Oct 2023 21:18:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b004068def185asm4181970wmo.28.2023.10.24.21.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 21:18:26 -0700 (PDT)
Date:   Wed, 25 Oct 2023 07:11:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Wenchao Hao <haowenchao22@gmail.com>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        dmaengine@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: scsi_debug: fix some bugs in
 sdebug_error_write()
Message-ID: <9767953c-480d-4ad9-a553-a45ae80c572b@kadam.mountain>
References: <96d50cf7-afec-46af-9d98-08099f8dc76e@moroto.mountain>
 <CAOptpSMTgGwyFkn8o6qAEnUKXh+_mOr8dQKAZUWfM_4QEnxzxw@mail.gmail.com>
 <44b0eca3-57c1-4edd-ab35-c389dc976273@kadam.mountain>
 <cbe14e3a-11c7-4da5-b125-5801244e27f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe14e3a-11c7-4da5-b125-5801244e27f2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 25, 2023 at 01:09:34AM +0800, Wenchao Hao wrote:
> Yes, there is bug here if write with .c code. Because your change to use
> strndup_user() would make write with dirty data appended to "ubuf" failed,

I don't understand this sentence.  What is "dirty" data in this context?

> can we fix it with following change:
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 67922e2c4c19..0e8ct724463f 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -1019,7 +1019,7 @@ static seize_t sdebug_error_write(struct file *file, const char __user *ubuf,
>         struct sdebug_err_inject *inject;
>         struct scsi_device *sdev = (struct scsi_device *)file->f_inode->i_private;
>  
> -       buf = kmalloc(count, GFP_KERNEL);
> +       buf = kzalloc(count + 1, GFP_KERNEL);

That would also fix the bug.

>         if (!buf)
>                 return -ENOMEM;
> 
> Or is there other kernel lib function which can address this issue?

I don't understand the issue.

regards,
dan carpenter

