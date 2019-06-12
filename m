Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4F542ADE
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 17:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfFLPYx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 11:24:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40240 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfFLPYx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jun 2019 11:24:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so18930384qtn.7;
        Wed, 12 Jun 2019 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x/y4rh2GpXVp2fvK0BIj6HcH04gYu7ik1dJuJV7JqSE=;
        b=gfaonzahNiQIay2TIzNRmKH4jfqBoa1rd4ukaLTrYRQkLOdLp/2X+zYhdgIRZjuL+K
         M5BnzEoMLwGRU0ca+2ghr+czB10fUMRNz15o2Yl3sItCK7ORKZWLOyRO33YxZe1+I7wX
         oJGEAHeAnxuxq5DIDNxwaL7LPR5SDkxCWlll7J91Z5/xkxwLaFSEJ3eKqELLHIiHj7w5
         oNfQx6zhhGF4PpAwBVYbvHURhwNORv0bMni9nOD2yvW8cJXLgd2yEWP41spERrfDl4IT
         F0SkvhzRsgjZItQJA33SFy2QIs0g6znV28uE5Lj+g4bDj8uGi2bF0+yszeI5v43VD5OT
         0h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=x/y4rh2GpXVp2fvK0BIj6HcH04gYu7ik1dJuJV7JqSE=;
        b=PwAISTp3+cUaxE13yYSyQJ/xeOSBWk818c/4KAaOlB8bsXAI7GpMOUG2mjWK9vVNi0
         gKSWyA9V3bp1fIxCbQbkQD8BFpnJiPczLxksSYFqdWuOSRtgjJDDsJhOjOYoFQRHWpHy
         MhPLjA/4lXz1tgduyHZNScYBycaWjm4ly5y1qmNZ5+tSBLPzAHMkq0T4GGZjdyH03rWo
         lotGuG/WbL88dtGzAq6ZzCMh71m3xkbpJKPw2xHBIlt9ewp3kSV/X7Kblhe3cudHNnQy
         9XjS/ZKh0y+u9n4xSum4Qf9vcDYRs4J01wwbpxHVYkKGx5xAA7u8/me3fGH8XOtcmb+o
         GhXg==
X-Gm-Message-State: APjAAAWjQz8hGYVkZrBmyseLTf71HJGiZfPJjmZFS9YL3YEbwFAAjo/L
        4MC5y25mEpzI4zTZ5SKCAqZh6AFm
X-Google-Smtp-Source: APXvYqye/2ePZackd8UnkSvmHspMqWBf3Ci8+wA0N4ZKXatISVMJv90tpsbH4oujNN2SjfCd7T+3Lw==
X-Received: by 2002:aed:3ed5:: with SMTP id o21mr69291746qtf.369.1560353092224;
        Wed, 12 Jun 2019 08:24:52 -0700 (PDT)
Received: from [10.84.150.66] ([167.220.148.66])
        by smtp.gmail.com with ESMTPSA id i17sm8068790qkl.71.2019.06.12.08.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 08:24:51 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 6/6] dma: qcom: hidma: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dan.j.williams@intel.com, vkoul@kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
 <20190612122557.24158-6-gregkh@linuxfoundation.org>
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
Message-ID: <8185a8b8-a0ce-4a86-84a2-b51391356052@kernel.org>
Date:   Wed, 12 Jun 2019 11:24:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612122557.24158-6-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 6/12/2019 8:25 AM, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Also, because there is no need to save the file dentry, remove the
> variables that were saving them as they were never even being used once
> set.
> 
> Cc: Sinan Kaya <okaya@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Interesting. Wouldn't debugfs_create_file() blow up if dir is NULL
for some reason?


+		debugfs_create_file("stats", S_IRUGO, dir, chan,
+				    &hidma_chan_fops);

Note that code ignores the return value of hidma_debug_init();
It was just trying to do clean up on debugfs failure by calling

	debugfs_remove_recursive(dmadev->debugfs);
