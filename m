Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD88BB41
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2019 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfHMOR1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Aug 2019 10:17:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:36483 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfHMOR1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Aug 2019 10:17:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 07:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,381,1559545200"; 
   d="scan'208";a="181196471"
Received: from mylly.fi.intel.com (HELO [10.237.72.59]) ([10.237.72.59])
  by orsmga006.jf.intel.com with ESMTP; 13 Aug 2019 07:17:25 -0700
Subject: Re: [PATCH] dmaengine: dw: Update Intel Elkhart Lake Service Engine
 acronym
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
References: <20190813080602.15376-1-jarkko.nikula@linux.intel.com>
 <20190813140729.GC30120@smile.fi.intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <82882d82-57e7-dabc-93af-6ec52c3fbc89@linux.intel.com>
Date:   Tue, 13 Aug 2019 17:17:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813140729.GC30120@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 8/13/19 5:07 PM, Andy Shevchenko wrote:
> On Tue, Aug 13, 2019 at 11:06:02AM +0300, Jarkko Nikula wrote:
>> Intel Elkhart Lake Offload Service Engine (OSE) will be called as
>> Intel(R) Programmable Services Engine (Intel(R) PSE) in documentation.
>>
>> Update the comment here accordingly.
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Seems similar we need for UART.
> 
You mean a0d993e8c143 ("serial: 8250_lpss: Enable HS UART on Elkhart 
Lake")? No Code or comment on that commit mention OSE, only commit log.

-- 
Jarkko
