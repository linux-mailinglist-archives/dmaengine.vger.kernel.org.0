Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1038C384
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2019 23:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfHMVVK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Aug 2019 17:21:10 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:29844 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfHMVVK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Aug 2019 17:21:10 -0400
Received: from belgarion ([90.76.53.202])
        by mwinf5d80 with ME
        id olM4200044MlyVm03lM4ry; Tue, 13 Aug 2019 23:21:07 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Tue, 13 Aug 2019 23:21:07 +0200
X-ME-IP: 90.76.53.202
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dma: pxa_dma: no need to check return value of debugfs_create functions
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
        <20190612122557.24158-4-gregkh@linuxfoundation.org>
        <87tvaorfc1.fsf@belgarion.home> <20190811070350.GA28202@kroah.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Tue, 13 Aug 2019 23:21:04 +0200
In-Reply-To: <20190811070350.GA28202@kroah.com> (Greg Kroah-Hartman's message
        of "Sun, 11 Aug 2019 09:03:50 +0200")
Message-ID: <87o90srccf.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Sat, Aug 10, 2019 at 09:27:26PM +0200, Robert Jarzmik wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> This is not strictly equivalent.
>> Imagine that the debugfs_create_dir() fails and returns NULL :
> How can that happen?
Well in v5.0-rc1 that could happen ... unfortunately that's also the code I
checked ...

>>  - in the former case, neither "state", "descriptors" nor "requesters" would be
>>    created
>>  - in the new code, "state", "descriptors" nor "requesters" will be created in
>>    the debugfs root directory
>
> I agree, but debugfs_create_dir() does not return a NULL on an error
> since many kernel releases.  Neither can debugfs_create_file() so really
> this test is not working at all as-is :)
Ah yes, you're right, I wasn't aware of the debugfs changes ...

But checking a bit further, your original mail is 2 monthes old, and this patch
was already merged in v5.2. I probably fell in a time-space anomaly, as I
received this mail only a couple of days ago.

Have a nice day.

-- 
Robert
