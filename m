Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84624FE5FD
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2019 20:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKOTsv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Nov 2019 14:48:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34203 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfKOTsv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Nov 2019 14:48:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id l202so9682710oig.1
        for <dmaengine@vger.kernel.org>; Fri, 15 Nov 2019 11:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=89ki5gCyFaFazPM4MT3GuICeyjOsNZnH539wVj6PzCM=;
        b=VPWwE9RrAqszxVB1mKYP6/s1DmY2ix8Y1fafLQWAW1wg1eaMprmTPWK/iPrrMUJsTB
         7HEWh2OpE4cCL76nODlrp2JnwOpKlYYMVjdoYSIPaXcFxcjAoA5oC9tfbmZ86sZE87qS
         kf1TVxe90rRN7AbhalLFMHiY57JoeloJ6qnB4tqTtyb/F3V9ygt/d+Fik42s54QbOsfP
         /0Mp7D/W4KFUqzRxjFNjxRYHCOArf612hqwEDcodf4WmkpkKtQERh4i/bj62U2U7lTvu
         L8iBUfClvKXkhGJjNB/jDJevtMJL7zKz0p46Bx1wFJVCEWjK5mwMY/8oQ/VumMGopZVZ
         uyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=89ki5gCyFaFazPM4MT3GuICeyjOsNZnH539wVj6PzCM=;
        b=dNPaFSB+RVdbgWwLiebrUesji41utWkrKuXVICGqyQa7Vywd/CC0CEomeaq3/K24BX
         THNN8bT7SGSpfZFwok26wsQ6BDt47x8UkZAlalhY7I8k08EDsJ2kD8Rj0MBu4VGMcZs3
         zv8BITeh6cY5Lgyfsd2LWap/vBZGc4JI3mUlRV++95PcizM04ZdRS9rA1QsZinudt2s6
         tAiA2vDQ1XeBy8sH/Rrfze4v5KGy4gyin764StJFfTndy3i8DX29MhvC3hBvm5snChvF
         ujia9HgJxkzVuqsolRCOaAUCjipgDzKRZbu8wi9P7TWAFU3LaaisCpX6IQ+GUEh/JaLh
         8e/Q==
X-Gm-Message-State: APjAAAU/k1gqq3r86jYW63Sh1A17uz6x9jouZkksV6Bp2aBVTRdlBa3U
        jbVLjh6m47PtvlYUfVHJGqaE3A==
X-Google-Smtp-Source: APXvYqxC+q6bqr48ncu6FV5lYoc6la8mAyX4ATuvLwxlhhukNSzuVzK+EEvv648084tqxyvuAKlo+Q==
X-Received: by 2002:aca:c4d3:: with SMTP id u202mr9701947oif.59.1573847330775;
        Fri, 15 Nov 2019 11:48:50 -0800 (PST)
Received: from localhost (42.sub-174-240-141.myvzw.com. [174.240.141.42])
        by smtp.gmail.com with ESMTPSA id z16sm3100151oih.56.2019.11.15.11.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:48:50 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:48:49 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Green Wan <green.wan@sifive.com>
cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] riscv: dts: add support for PDMA device of HiFive
 Unleashed Rev A00
In-Reply-To: <20191107084955.7580-3-green.wan@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1911151148400.3813@viisi.sifive.com>
References: <20191107084955.7580-1-green.wan@sifive.com> <20191107084955.7580-3-green.wan@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 7 Nov 2019, Green Wan wrote:

> Add PDMA support to (arch/riscv/boot/dts/sifive/fu540-c000.dtsi)
> 
> Signed-off-by: Green Wan <green.wan@sifive.com>

Thanks, queued for v5.5-rc1.


- Paul
