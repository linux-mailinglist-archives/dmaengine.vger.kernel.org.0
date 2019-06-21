Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BDE4E25B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2019 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFUIv0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jun 2019 04:51:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45041 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFUIvZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jun 2019 04:51:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so2653333plr.11;
        Fri, 21 Jun 2019 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+Ey1/zIANVKjOHs9alzo8W/4IBUVGBNpf5H/Uu5sYQ=;
        b=WMGTVYnxeta7bJuKWJaxng82mq0WGHyDIWxsY7VMJPIfNcmly6MLydUfG9D05vHYyx
         igssGwx13Gw6rPzQWmqPyvx/aw1S9kZQu19Zrao9rXNtLHjHCLyFawVPBQRzjp4lXJZB
         jcnQR3xkHjoBatnNnmqjXxSYL/tptGGdL7lN5eaB1ssw7mWSxhiWYZDIS7mQ09fFoP2i
         jIkJ4PAcd9GJFo5nSwXesKxapurKBrTn69gcxeImQE5jDjvE8Ezk5FiFNGVk8Zim0jP7
         6etz5OuXJsLl17MWOtn0K4RUEftLSayw1BkBPu90Vc5wxTd0dpQHLQuNDz/oklmVajqR
         EHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+Ey1/zIANVKjOHs9alzo8W/4IBUVGBNpf5H/Uu5sYQ=;
        b=JWyvK3RFzaKHRu5PA5cXfAJspCvB+yrsw9Lpbf59hUF81cvHysWYxHo/KfcQ9gGTmI
         emgM6x8e4qeyYofaj3qS14T07UtHK6u2BYGqOvTpMDEiCRWkHMV5BWY0dYuvVIVF0UvS
         oirXuCxAGmWkUL1juyiUoIgPip9KrxLJ/KzpRY8WYdx8vsiZzZF/icpmpuOcyML2k3fm
         gcNf3/8V4d3H8lwCbE2qKZqgnltVfy+rKFXzqbtNDJuN6ttrUunjGwIfaMhXTXRvAfJx
         uBRISABWcR3omT/4jkrCsy9XssBeBhINYiOBith/r2kk43iZAFc6+kCRPiQhSDjHHn0r
         a/Fw==
X-Gm-Message-State: APjAAAUAhZtbIF62eBPHButCf2S9QJByr0tMogtYASM3+PxwNri6VI7p
        el62CjI5CeEgN69Bl4GaTXIL5KdJ0ytAboLyA8c=
X-Google-Smtp-Source: APXvYqyOpvQVVGtV7nvdT8LQ/xEJTqraCie7bRXXw5TzddTc1EbX+bBOkok9CcEjvT2Ly8vhf5mpQ2WjkOFwd+lud+8=
X-Received: by 2002:a17:902:ab90:: with SMTP id f16mr127338454plr.262.1561107084967;
 Fri, 21 Jun 2019 01:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190617131820.2470686-1-arnd@arndb.de> <DM6PR12MB40101798EDD46EF4B8E0E0E1DAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40101798EDD46EF4B8E0E0E1DAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Jun 2019 11:51:13 +0300
Message-ID: <CAHp75Vf_1QT1ozhw=bsLwOERSg501DFK2U9OMQ4y95GN+VayEQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: dw-edma: fix endianess confusion
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 21, 2019 at 11:43 AM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
>
> Hi,
>
> On Mon, Jun 17, 2019 at 14:17:47, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > When building with 'make C=1', sparse reports an endianess bug:
>
> I didn't know that option.

And CF="-D__CHECK_ENDIAN__" is useful.


-- 
With Best Regards,
Andy Shevchenko
