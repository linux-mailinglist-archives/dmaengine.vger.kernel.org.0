Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7070D492378
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jan 2022 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiARKGA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jan 2022 05:06:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42922 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiARKF6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jan 2022 05:05:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2435421135;
        Tue, 18 Jan 2022 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642500357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bfaPyBaXcXcaMldZv9qZyKNLa9LaQmex0/8zwqmvtO0=;
        b=Dw3bRF4+RdIgIw/cD5GboHQ9h98YZtHNow8GllWU+NGOSWEpZFtUonpSKQxBuLcBvzLwmd
        htNpIwJJhEKCiuKfPjg3zEapE2hU9oOOoQz+r2RloM9H46H/eryAOk03urNDYAFUcXGOPB
        SLiWezpzmQyK9R7JDN/yzCGgXjn30dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642500357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bfaPyBaXcXcaMldZv9qZyKNLa9LaQmex0/8zwqmvtO0=;
        b=/0wtVn54vCalWxE99ldq+qTX0TgIfDWhrmQB7DEuYt1fR3S0Vr7IAKyqOR5MYfQgoMJL0/
        Jlcp9idrJuMsUpCA==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6D459A3B83;
        Tue, 18 Jan 2022 10:05:56 +0000 (UTC)
Date:   Tue, 18 Jan 2022 10:05:54 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Alexander Fomichev <fomichev.ru@gmail.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux@yadro.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] Scheduler: DMA Engine regression because of sched/fair
 changes
Message-ID: <20220118100553.GR3301@suse.de>
References: <20220112152609.gg2boujeh5vv5cns@yadro.com>
 <20220112170512.GO3301@suse.de>
 <20220117081905.a4pwglxqj7dqpyql@yadro.com>
 <20220117102701.GQ3301@suse.de>
 <20220118020448.2399-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220118020448.2399-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jan 18, 2022 at 10:04:48AM +0800, Hillf Danton wrote:
> > > > 5) What DMA Engine enabled drivers (and dmatest) should use as design
> > > > pattern to conform migration/cache behavior? Does scheduler optimisation
> > > > conflict to DMA Engine performance in general?
> > > > 
> > > 
> > > I'm not familiar with DMA engine drivers but if they use wake_up
> > > interfaces then passing WF_SYNC or calling the wake_up_*_sync helpers
> > > may force the migration.
> > > 
> > 
> > Thanks for the advice. I'll try to check if this is a solution.
> 
> Check if cold cache provides some room for selecting CPU.
> 
> Only for thoughts now.
> 

That will still favour migrating tasks between CPUs that share LLC cache
at the expense of losing some higher level caches and cpufreq state
(depending on the CPUfreq governor).

-- 
Mel Gorman
SUSE Labs
