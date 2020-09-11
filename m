Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C21265BAB
	for <lists+dmaengine@lfdr.de>; Fri, 11 Sep 2020 10:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgIKIdf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Sep 2020 04:33:35 -0400
Received: from foss.arm.com ([217.140.110.172]:56524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgIKIde (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Sep 2020 04:33:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE6CF113E;
        Fri, 11 Sep 2020 01:33:33 -0700 (PDT)
Received: from [10.57.17.177] (unknown [10.57.17.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2B4B3F73C;
        Fri, 11 Sep 2020 01:33:32 -0700 (PDT)
Subject: Re: 6b41030fdc790 broke dmatest badly
From:   Vladimir Murzin <vladimir.murzin@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20200904173401.GH1891694@smile.fi.intel.com>
 <d95f1b54-2a62-7b79-c53c-c8179324e935@arm.com>
 <20200907120440.GC1891694@smile.fi.intel.com>
 <004640d8-e236-4b75-1bfd-cc386bbf08a6@arm.com>
 <20200907140502.GK1891694@smile.fi.intel.com>
 <54ba60c3-9a04-51ac-688c-425b85202b18@arm.com>
Message-ID: <578f9c4d-3d29-d1f3-17f7-94dfe24403c4@arm.com>
Date:   Fri, 11 Sep 2020 09:34:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <54ba60c3-9a04-51ac-688c-425b85202b18@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 9/7/20 5:52 PM, Vladimir Murzin wrote:
> On 9/7/20 3:05 PM, Andy Shevchenko wrote:
>> On Mon, Sep 07, 2020 at 02:06:23PM +0100, Vladimir Murzin wrote:
>>> On 9/7/20 1:06 PM, Andy Shevchenko wrote:
>>>> On Mon, Sep 07, 2020 at 12:03:26PM +0100, Vladimir Murzin wrote:
>>>>> On 9/4/20 6:34 PM, Andy Shevchenko wrote:
>>>>>> It becomes a bit annoying to fix dmatest after almost each release.
>>>>>> The commit 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
>>>>>> broke my use case when I tried to start busy channel.
>>>>>>
>>>>>> So, before this patch
>>>>>> 	...
>>>>>> 	echo "busy_chan" > channel
>>>>>> 	echo 1 > run
>>>>>> 	sh: write error: Device or resource busy
>>>>>> 	[ 1013.868313] dmatest: Could not start test, no channels configured
>>>>>>
>>>>>> After I have got it run on *ALL* available channels.
>>>>>
>>>>> Is not that controlled with max_channels? 
>>>>
>>>> How? I would like to run the test against specific channel. That channel is
>>>> occupied and thus I should get an error. This is how it suppose to work and
>>>> actually did before your patch.
>>>
>>> Since you highlighted "ALL" I though that was an issue, yet looks like you
>>> expect run command would do nothing, correct?
>>
>> Yes!
>>
>>> IIUC attempt to add already occupied channel is producing error regardless of
>>> my patch and I do not see how error could come from run command.
>>
>> We need to save the status somewhere that the channel setter has been called
>> unsuccessfully. And propagate an error to the run routine.
> 
> I'm not familiar with the code to propose nice and elegant solution, but for the
> start (build only)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 45d4d92..40dba6b 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -129,6 +129,7 @@ struct dmatest_params {
>   * @nr_channels:	number of channels under test
>   * @lock:		access protection to the fields of this structure
>   * @did_init:		module has been initialized completely
> + * @misconfig:		test has faced configuration issues
>   */
>  static struct dmatest_info {
>  	/* Test parameters */
> @@ -139,6 +140,7 @@ static struct dmatest_info {
>  	unsigned int		nr_channels;
>  	struct mutex		lock;
>  	bool			did_init;
> +	bool			misconfig;
>  } test_info = {
>  	.channels = LIST_HEAD_INIT(test_info.channels),
>  	.lock = __MUTEX_INITIALIZER(test_info.lock),
> @@ -1184,16 +1186,26 @@ static int dmatest_run_set(const char *val, const struct kernel_param *kp)
>  		return ret;
>  	} else if (dmatest_run) {
>  		if (!is_threaded_test_pending(info)) {
> -			pr_info("No channels configured, continue with any\n");
> -			if (!is_threaded_test_run(info))
> -				stop_threaded_test(info);
> -			add_threaded_test(info);
> +			/*
> +			 * We have nothing to run. This can be due to:
> +			 */
> +			if (info->misconfig) {
> +				/* 1) Mis-configuration */
> +				pr_warn("Channels mis-configured, could not continue\n");
> +				goto out;
> +			} else {
> +				/* 2) We rely on defaults */
> +				pr_info("No channels configured, continue with any\n");
> +				if (!is_threaded_test_run(info))
> +					stop_threaded_test(info);
> +				add_threaded_test(info);
> +			}
>  		}
>  		start_threaded_tests(info);
>  	} else {
>  		stop_threaded_test(info);
>  	}
> -
> +out:
>  	mutex_unlock(&info->lock);
>  
>  	return ret;
> @@ -1226,6 +1238,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>  				strlcpy(chan_reset_val,
>  					dma_chan_name(dtc->chan),
>  					sizeof(chan_reset_val));
> +				info->misconfig = true;
>  				ret = -EBUSY;
>  				goto add_chan_err;
>  			}
> @@ -1246,6 +1259,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>  		 */
>  		if ((strcmp(dma_chan_name(dtc->chan), strim(test_channel)) != 0)
>  		    && (strcmp("", strim(test_channel)) != 0)) {
> +			info->misconfig = true;
>  			ret = -EINVAL;
>  			strlcpy(chan_reset_val, dma_chan_name(dtc->chan),
>  				sizeof(chan_reset_val));
> @@ -1255,6 +1269,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>  	} else {
>  		/* Clear test_channel if no channels were added successfully */
>  		strlcpy(chan_reset_val, "", sizeof(chan_reset_val));
> +		info->misconfig = true;
>  		ret = -EBUSY;
>  		goto add_chan_err;
>  	}
> 
>>
>>> As for my patch it restores behaviour of how it supposed to work prior d53513d5dc28
>>> where run command would execute with default settings if under-configured.
>>
>> Yeah, yet another breaking patch series (I have fixed one bug in that) which
>> has been dumped and someone disappeared...
>>
>> Yes, and here is a corner case. I have batch script which fills sysfs
>> parameters with something meaningful. However, when error happens in channel
>> setter the run kick off, luckily, b/c of regression you have noticed, doesn't
>> happen.
>>
>> And this behaviour as far as I remember was previously before the d53513d5dc28.
>> At least I remember that I wrote my scripts few years ago and they worked.
> 
> Can we actually confirm behaviour before d53513d5dc28? That would add confidence
> that we are doing right thing.
>

An update on this?

Vladimir

 
> As for scripts it looks like folk have them covering different cases yet seems
> not something run regularly, so should not we cooperate with kernel CI team or its
> equivalent and try to get (some of?) them into their environment?
>
> Cheers
> Vladimir 
> 
>>
>>>>>> dmatest compiled as a module.
>>>>>>
>>>>>> Fix this ASAP, otherwise I will send revert of this and followed up patch next
>>>>>> week.
>>>>>
>>>>> I don't quite get it, you are sending revert and then a fix rather then helping
>>>>> with a fix?
>>>>
>>>> Correct.
>>>>
>>>>> What is reason for such extreme (and non-cooperative) flow?
>>>>
>>>> There are few reasons:
>>>>  - the patch made a clear regression
>>>>  - I do not understand what that patch is doing and how
>>>>  - I do not have time to look at it
>>>>  - we are now at v5.9-rc4 and it seems like one or two weeks time to get it
>>>>    into v5.9 release
>>>>  - and I'm annoyed by breaking this module not the first time for the last
>>>>    couple of years
>>>>
>>>> And on top of that it's not how OSS community works. Since you replied, I give
>>>> you time to figure out what's going on and provide necessary testing if needed.
>>>>
>>>>> P.S.
>>>>> Unfortunately, I do not have access to hardware to run reproducer.
>>>>
>>>> So, please, propose a fix without it. I will test myself.
>>>>
>>>
>>
> 

