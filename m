Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02A742BEB
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfFLQRf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 12:17:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33641 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfFLQRe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jun 2019 12:17:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id x2so18228737qtr.0;
        Wed, 12 Jun 2019 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U2vYqaPYdWtpzfrzovO9feBjUjZjzjyP3l5hohlZ2Qw=;
        b=D9u7HA9acjMxG5IDmmk52QrmRvl60xY0S/bA+fJ34Ie35XIKGzY6OZbUdNy24KUCLn
         v0k5PGGDhJJgsyTqYBiiIENrszMhPVIwWIZMJc/dqo5GOCau43SF6mKGAE5ODH5y1H13
         U57jobrMEWYOn66qKQvvfFa4ja97bbNE9Tx1iBlqV2aFM0WA0Lq+G/DmW8CHWvISaq41
         RGl1t9orYPpMJ3yC8uKY6EIXm1djVIRawvm5q3HOQbZWe6/wdZeCgq/AD9jliSdbJp9L
         K8thiwuO7coFPOPDzo9o7IdUv3SZ3asi0RWidz41BJ1xgitsFXuoSyX9F5rR5kNX04Ls
         KkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=U2vYqaPYdWtpzfrzovO9feBjUjZjzjyP3l5hohlZ2Qw=;
        b=gmH5z9Fu6JNSzz4bjTnJCbkXB05mk0j25cMhPopK8Ujll9dpl3EJex/gvUhJb+8KtA
         vt6X1jruHX3na5zhSy5hSJRAKyNXltj/CDTBRsQXmyYlK9+w0CNcAyO2CrTPkQJObVyz
         p0cuRJGWBfvDk7vVRjtoCIQyfwryGQGU5hkP0251Cy75oKP5rn5y3wT77eP0t7GuKzM6
         EuzulFGTsIFEH6AyV9aHc7UIYOfc0vtX8hFBoP+Opt/j2AmlUbLH2hlzvbNS4RNo34KP
         jImBbEaqcNx8YoIgkCgkNOujdsiG22TVgL2EtkNIHsUdbK5iUQG12pmn4K65C+A6YAF6
         xafQ==
X-Gm-Message-State: APjAAAUn0RLjpXyTzIDsJnJVPePQDVhdXZQKZreltCAkktoukVpPDV7r
        QkGGtjmM7fzCAqfyH4UzTK5keWuz
X-Google-Smtp-Source: APXvYqwNdJ0Fb29xxjQiS/MFAVscn9cJ6eF2PqS8LVs89NTOxmhErJbcoeaTaWjZzxjqt76lwlO+AA==
X-Received: by 2002:ac8:1016:: with SMTP id z22mr6334107qti.287.1560356253656;
        Wed, 12 Jun 2019 09:17:33 -0700 (PDT)
Received: from [10.84.150.66] ([167.220.149.66])
        by smtp.gmail.com with ESMTPSA id n10sm36819qke.72.2019.06.12.09.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:17:32 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 6/6] dma: qcom: hidma: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
 <20190612122557.24158-6-gregkh@linuxfoundation.org>
 <8185a8b8-a0ce-4a86-84a2-b51391356052@kernel.org>
 <20190612153948.GA21828@kroah.com>
Openpgp: preference=signencrypt
Autocrypt: addr=okaya@kernel.org; keydata=
 mQENBFrnOrUBCADGOL0kF21B6ogpOkuYvz6bUjO7NU99PKhXx1MfK/AzK+SFgxJF7dMluoF6
 uT47bU7zb7HqACH6itTgSSiJeSoq86jYoq5s4JOyaj0/18Hf3/YBah7AOuwk6LtV3EftQIhw
 9vXqCnBwP/nID6PQ685zl3vH68yzF6FVNwbDagxUz/gMiQh7scHvVCjiqkJ+qu/36JgtTYYw
 8lGWRcto6gr0eTF8Wd8f81wspmUHGsFdN/xPsZPKMw6/on9oOj3AidcR3P9EdLY4qQyjvcNC
 V9cL9b5I/Ud9ghPwW4QkM7uhYqQDyh3SwgEFudc+/RsDuxjVlg9CFnGhS0nPXR89SaQZABEB
 AAG0HVNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+iQFOBBMBCAA4FiEEYdOlMSE+a7/c
 ckrQvGF4I+4LAFcFAlztcAoCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQvGF4I+4L
 AFfidAf/VKHInxep0Z96iYkIq42432HTZUrxNzG9IWk4HN7c3vTJKv2W+b9pgvBF1SmkyQSy
 8SJ3Zd98CO6FOHA1FigFyZahVsme+T0GsS3/OF1kjrtMktoREr8t0rK0yKpCTYVdlkHadxmR
 Qs5xLzW1RqKlrNigKHI2yhgpMwrpzS+67F1biT41227sqFzW9urEl/jqGJXaB6GV+SRKSHN+
 ubWXgE1NkmfAMeyJPKojNT7ReL6eh3BNB/Xh1vQJew+AE50EP7o36UXghoUktnx6cTkge0ZS
 qgxuhN33cCOU36pWQhPqVSlLTZQJVxuCmlaHbYWvye7bBOhmiuNKhOzb3FcgT7kBDQRa5zq1
 AQgAyRq/7JZKOyB8wRx6fHE0nb31P75kCnL3oE+smKW/sOcIQDV3C7mZKLf472MWB1xdr4Tm
 eXeL/wT0QHapLn5M5wWghC80YvjjdolHnlq9QlYVtvl1ocAC28y43tKJfklhHiwMNDJfdZbw
 9lQ2h+7nccFWASNUu9cqZOABLvJcgLnfdDpnSzOye09VVlKr3NHgRyRZa7me/oFJCxrJlKAl
 2hllRLt0yV08o7i14+qmvxI2EKLX9zJfJ2rGWLTVe3EJBnCsQPDzAUVYSnTtqELu2AGzvDiM
 gatRaosnzhvvEK+kCuXuCuZlRWP7pWSHqFFuYq596RRG5hNGLbmVFZrCxQARAQABiQEfBBgB
 CAAJBQJa5zq1AhsMAAoJELxheCPuCwBX2UYH/2kkMC4mImvoClrmcMsNGijcZHdDlz8NFfCI
 gSb3NHkarnA7uAg8KJuaHUwBMk3kBhv2BGPLcmAknzBIehbZ284W7u3DT9o1Y5g+LDyx8RIi
 e7pnMcC+bE2IJExCVf2p3PB1tDBBdLEYJoyFz/XpdDjZ8aVls/pIyrq+mqo5LuuhWfZzPPec
 9EiM2eXpJw+Rz+vKjSt1YIhg46YbdZrDM2FGrt9ve3YaM5H0lzJgq/JQPKFdbd5MB0X37Qc+
 2m/A9u9SFnOovA42DgXUyC2cSbIJdPWOK9PnzfXqF3sX9Aol2eLUmQuLpThJtq5EHu6FzJ7Y
 L+s0nPaNMKwv/Xhhm6Y=
Message-ID: <78da53a1-1363-fad8-16fa-4dfc6555f4e4@kernel.org>
Date:   Wed, 12 Jun 2019 12:17:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612153948.GA21828@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 6/12/2019 11:39 AM, Greg Kroah-Hartman wrote:
>> Interesting. Wouldn't debugfs_create_file() blow up if dir is NULL
>> for some reason?
> It will create a file in the root of debugfs.  But how will that happen?
> debugfs_create_dir() can not return NULL.

I see.

> 
>> +		debugfs_create_file("stats", S_IRUGO, dir, chan,
>> +				    &hidma_chan_fops);
>>
>> Note that code ignores the return value of hidma_debug_init();
>> It was just trying to do clean up on debugfs failure by calling
>>
>> 	debugfs_remove_recursive(dmadev->debugfs);
> Is that a problem?

I just wanted to double check. You probably want to remove the return
value on debugfs_create_file() to prevent others from doing the same
thing.

Acked-by: Sinan Kaya <okaya@kernel.org>
